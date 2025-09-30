Return-Path: <linux-kernel+bounces-838009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E62EBAE369
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2365380216
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FECF26A1AB;
	Tue, 30 Sep 2025 17:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CEeqHLq9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5920D303A16
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759253758; cv=none; b=baVrL/1GxrguuSzRFskqofeI1EDYklZqOT2zUa8d7hJMTf393u3+qMucOp1N1ablwWh8iy9lmUklpEX5bgJP6aw4cejxQGcOpa4nULD8t27+RIZVY5u+1TWWzzQv+jKQ+MJdPukh93AP4P3jLzOTUFP+tq0R05RoFKI4JHHotbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759253758; c=relaxed/simple;
	bh=cA+GuZ8vUMDcn1Dg0PjYnMccmnveoznbfhGWc5zNCCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pgiCKBYiq7zDMROw322zG9p3PTgVYh0cXLKsGElwNFaNUFJ78wFvCmRnY0bkFeZzCQ47NXaxaTJ9qiLGzKk4MPstUQcmoaGqmh7BGcFXA7momZD6gBDXGoKQt/8RM1pcNjHDBFQqsg6s79mZwyaJTIpH6jPEVui4U/orPnhCmqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CEeqHLq9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759253756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dxpyWC+z0+GgUOe2275ohM0grFu0b3i5OGv1YPDEOOQ=;
	b=CEeqHLq9h6OnLaV+u/4HWNjmETy6fsK2EmMSg8ON97BhjX/ZKCsK2GiwkiNB4TzYL+XEZG
	szCgjgfx1fKPNGkgOw5OlfT6lFW0ZQ8OCWxTsHgXeJzScFV17VKHZzqao2V7bW0wSefNL6
	By6tVd/BcspABQc7QiM4IBjJqSI+NM8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-10L7yOdJNL-3mlYbAcT-sQ-1; Tue, 30 Sep 2025 13:35:54 -0400
X-MC-Unique: 10L7yOdJNL-3mlYbAcT-sQ-1
X-Mimecast-MFC-AGG-ID: 10L7yOdJNL-3mlYbAcT-sQ_1759253753
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-41066f050a4so3097800f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759253753; x=1759858553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dxpyWC+z0+GgUOe2275ohM0grFu0b3i5OGv1YPDEOOQ=;
        b=SKO+U78x42zRPysg2SmCw4+g7840wtKD1VgLmnQPssMSmEiD90FcSmo3/TGMXArG+h
         WythEyNHnFa5ZuAzhfbQO0t5obka2AYaGQYtWtLdQVAeCMMNsJ+cYZt310gno6tSmnhU
         zd67XUiGkT94hytVX2/Ft67QJXWoBA9mONEqgc1SWDLS17flSHoqpnMVyRPeE2krtpKn
         7uPjZV/DGzAKrQaPHK7UcI3fOeCF3mLgeFwSMK772VQHMkNoGliL0QjaHX+GNKJEsEEZ
         cYv1h/njKGnJ7sclKrl8EXA8gAKYpbkr8jEKxJi9VRR/tU1qHXGmO5UVrBZYxJUZlsJy
         y0mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWig6UEK5AQvBHNF/Wc8Htil7s1CFEZfeLyskx4BIRauUiyYelklZmTLaJ0+tvJ85a3bkSYIEmSBYIdkn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL3iEGBrn8HJucBnS/pQCc7m85KGUkES9amsvt+DAv+pFVoFNM
	qewvhpPD8quNQdhfDurG8LFLmnf3md74+/2qG/fn3wMabS1YqNBrk8jOfih+pC7jvfOHEXWdaMo
	M1sMlQLcA+4NYrI/EseqSKfwVxNZDj3tq1TWN1qLKQ3B/qKh1cRHvbKwqjW5g5fWg7rUojcSUrl
	NHrOkq5ZgK0EeEL8lOZaAE2D+C/2WFnL0TH3r3gpmk
X-Gm-Gg: ASbGncutBmu4rk+GoFXdp/5Z8pH8WWBWn9hB+iq/DV7+tA9J+eLZs+9XuohXeiFAeve
	hnORuE+EebEBYyupWi/GREd8UYhZQyIccWbSRJy7K3/9nXpqVwOhOae38zhifAmQSaZX0eLaXMx
	mKX9jY/N5Oxb+mwOPIT3yx5E/FuXw3S9PrwePd3ZKk55kd0AnrYim3nBY/RwEBVDN194hgP7TcM
	3fIXZbQCnzDc+U47882uFtlPc+b/izS
X-Received: by 2002:a05:600c:1da5:b0:459:d451:3364 with SMTP id 5b1f17b1804b1-46e6126a7a0mr5884755e9.24.1759253753275;
        Tue, 30 Sep 2025 10:35:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKPvT1CCgwVJb3rScTwbJPb+4nEbYDGCeYf8obJyyGqHWVpBgGTiZ6pg1mDGgl3uwkm82Nv1AW7LuKBbqZEaE=
X-Received: by 2002:a05:600c:1da5:b0:459:d451:3364 with SMTP id
 5b1f17b1804b1-46e6126a7a0mr5884435e9.24.1759253752462; Tue, 30 Sep 2025
 10:35:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927060910.2933942-1-seanjc@google.com> <20250927060910.2933942-8-seanjc@google.com>
In-Reply-To: <20250927060910.2933942-8-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 30 Sep 2025 19:35:40 +0200
X-Gm-Features: AS18NWBnsoSryzCQfIOe25iLO2gHWRo2iGtVD2ADwzO_Avqip5ID8Or--bNDX_Q
Message-ID: <CABgObfY0xtd1nB74deM3xNinFkb1tixHL0WYMd=qmT77tTCLAA@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: SNP CipherTextHiding for 6.18
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 8:09=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> The tag has all the details of the feature.  Note that this is based dire=
ctly
> on the v6.18-ccp tag from the cryptodev tree.  I included all of the ccp
> commits in the shortlog just in case the KVM pull request lands before th=
e
> crypto pull request.
>
> The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d5=
85:
>
>   Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-ciphertext-6.18

Pulled, thanks.

Paolo

> for you to fetch changes up to 6c7c620585c6537dd5dcc75f972b875caf00f773:
>
>   KVM: SEV: Add SEV-SNP CipherTextHiding support (2025-09-15 10:14:11 -07=
00)
>
> ----------------------------------------------------------------
> KVM SEV-SNP CipherText Hiding support for 6.18
>
> Add support for SEV-SNP's CipherText Hiding, an opt-in feature that preve=
nts
> unauthorized CPU accesses from reading the ciphertext of SNP guest privat=
e
> memory, e.g. to attempt an offline attack.  Instead of ciphertext, the CP=
U
> will always read back all FFs when CipherText Hiding is enabled.
>
> Add new module parameter to the KVM module to enable CipherText Hiding an=
d
> control the number of ASIDs that can be used for VMs with CipherText Hidi=
ng,
> which is in effect the number of SNP VMs.  When CipherText Hiding is enab=
led,
> the hared SEV-ES/SEV-SNP ASID space is split into separate ranges for SEV=
-ES
> and SEV-SNP guests, i.e. ASIDs that can be used for CipherText Hiding can=
not
> be used to run SEV-ES guests.
>
> ----------------------------------------------------------------
> Ashish Kalra (7):
>       crypto: ccp - New bit-field definitions for SNP_PLATFORM_STATUS com=
mand
>       crypto: ccp - Cache SEV platform status and platform state
>       crypto: ccp - Add support for SNP_FEATURE_INFO command
>       crypto: ccp - Introduce new API interface to indicate SEV-SNP Ciphe=
rtext hiding feature
>       crypto: ccp - Add support to enable CipherTextHiding on SNP_INIT_EX
>       KVM: SEV: Introduce new min,max sev_es and sev_snp asid variables
>       KVM: SEV: Add SEV-SNP CipherTextHiding support
>
>  Documentation/admin-guide/kernel-parameters.txt |  21 ++++
>  arch/x86/kvm/svm/sev.c                          |  68 +++++++++++--
>  drivers/crypto/ccp/sev-dev.c                    | 127 ++++++++++++++++++=
+++---
>  drivers/crypto/ccp/sev-dev.h                    |   6 +-
>  include/linux/psp-sev.h                         |  44 +++++++-
>  include/uapi/linux/psp-sev.h                    |  10 +-
>  6 files changed, 249 insertions(+), 27 deletions(-)
>


