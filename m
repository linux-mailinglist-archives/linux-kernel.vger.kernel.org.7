Return-Path: <linux-kernel+bounces-728377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C04B027A1
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 01:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5799D1CA7E73
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 23:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68D1223714;
	Fri, 11 Jul 2025 23:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FsglWUwf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE86322259D
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 23:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752276361; cv=none; b=DpJ4+IQaD5jY6SSdvl3DtYDLQt8TMcRqf85ndcoytlGYx1YtlMh158tPxpiwBkxJj9KoTXmw2MobCJOSuOGGzQO1SPZKfT/9aoy1wK3123mCrlP1dLAUL8fg+9Cy/47IMh6HNwvu6z9ZTITxxUXxQxWGIp5NfzlF5A0I2/IAKAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752276361; c=relaxed/simple;
	bh=FTjm64xHe0mUQGe0gmdkpS1UKnLUFTMDb4s/LwJnZHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TQVz+Waz2Lp1s2BaQyqIy5hsU2FEclKHSbVPeeAUr/GWoUbYi+3Efku1qIJxOyjDimumGKtU7YCyS1QYKKwfcJw/xEvzw0dgbGHbz96CojrFRmoAtODH0DZRrUM84cFZEfvMSoxmAQGWhYWe3na9R7KPR1MQCKVt3yQx/tHzAHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FsglWUwf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752276357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KNnitWUyVMmZ677TXjq4fGNMFjZQx7zQ4oPAZSNDf8g=;
	b=FsglWUwfjIUydNUMn1fICrCrdhCQgcxfhBv6QlhPq/oSvtEyjFxePso0I7r7Ft1h13eArv
	EEXNu+BFXTQpWcYaBCwDrYzabSgKBDAYgQMyvj093hz1DpUh0raJy/qagULI10nKOXSlRR
	AdZAOFtsFqWkT1iMsArpp7kPnIfRw20=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-XWAvxp4RPOCabqu9HV25Lw-1; Fri, 11 Jul 2025 19:25:56 -0400
X-MC-Unique: XWAvxp4RPOCabqu9HV25Lw-1
X-Mimecast-MFC-AGG-ID: XWAvxp4RPOCabqu9HV25Lw_1752276355
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ae0d76b4f84so211781766b.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 16:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752276355; x=1752881155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KNnitWUyVMmZ677TXjq4fGNMFjZQx7zQ4oPAZSNDf8g=;
        b=eQqcJccou6sGFeigFQOO9VjA5VZhqbRfA7s8z9vOR+9H7XwARtvN0GX4OM42xY3fcz
         BhSFZaPGKB6I6/A6dGLXX+k820WEvkSMWRx9nr99cf23Gnk1XwrXAaqVoTYhgON3BCVy
         fXyDVefcOYm0B2esnVCdO79KDuBEC38vPwl5IrTLGb2sadMyPla7cBXp/KBvWg7lPWOt
         Xpu5rf8y5+l5uvscTa9dXXkx+CbJozkFNjCDP47UC3FhM/N8YfreNURXNzlsZWyDRE5K
         Wg5iRi+81pxo75Qe8TwhCFaHU6IhZzQDHw95Bxsu3+xaFAQKZGXWfwxe1k7vT9SP5+R2
         fFFA==
X-Forwarded-Encrypted: i=1; AJvYcCWBf5dPY8f11XOqzYLmh+V8p+iMESd9WRyBX4ebJvkm57eVIhQXyOD3dTRqh03LNutHZLhAshYumPb2B6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjnAD/vs5UnATKq5doo8w1jOx8ZaFC07nv/6Ep5XbeNoSGmrAW
	KK5NbKX0cEg/oJ0Z2WTeLf/DfZ6pIR5Ft5nNQX7vjwc8rzI/QG8hyoNyLY6TDaMB3rTh6dBdeAW
	Z0mHDA6Eo+mv8SCLVq2k3OB01S6IuaGCDGZ+kpjoQ13DWrrDBQPvxA73lnAOvAXBqzC0Z+I38y3
	MgiQs1XX/ZvJm5Yo9ymT/C3SthtxhOxXq1tT6B6ViJ
X-Gm-Gg: ASbGncusmBc79DkYWP/jVphOD8GatNOXy4I0gFcw5bNhmAe96qAEzMMqUZUm5yD77Gm
	BSlMN/5eU0CLKg+9H7JB9Z7kS31tt6ORd7UQcm/FxDEPiuhmCbCjcNVK3ZwLhp6Gr84TwAIOzDl
	ih34PUh0KteuAtJpFGjkqcrw==
X-Received: by 2002:a17:907:1b05:b0:ad9:f54f:70a2 with SMTP id a640c23a62f3a-ae6fbdc90f4mr531763666b.22.1752276355376;
        Fri, 11 Jul 2025 16:25:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFt+iJFpZ7hKPJdxIrpDsRa3jGHWrIka/5oKF32jekBQp3esoTQv/Phk6pp434QyDFneeZCLDCHJ81+4M08gnA=
X-Received: by 2002:a17:907:1b05:b0:ad9:f54f:70a2 with SMTP id
 a640c23a62f3a-ae6fbdc90f4mr531761466b.22.1752276355051; Fri, 11 Jul 2025
 16:25:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711053509.194751-1-thuth@redhat.com> <2025071125-talon-clammy-4971@gregkh>
 <9f7242e8-1082-4a5d-bb6e-a80106d1b1f9@redhat.com> <2025071152-name-spoon-88e8@gregkh>
 <aHC-Ke2oLri_m7p6@infradead.org> <2025071119-important-convene-ab85@gregkh>
 <CAC1cPGx0Chmz3s+rd5AJAPNCuoyZX-AGC=hfp9JPAG_-H_J6vw@mail.gmail.com> <aHGafTZTcdlpw1gN@gate>
In-Reply-To: <aHGafTZTcdlpw1gN@gate>
From: Richard Fontana <rfontana@redhat.com>
Date: Fri, 11 Jul 2025 19:25:44 -0400
X-Gm-Features: Ac12FXznuBL3348HIkyZK48dfJrdmjVLqm_3FxI1CyeUB1LpyaZRNLgOhXRZp_o
Message-ID: <CAC1cPGzLK8w2e=vz3rgPwWBkqs_2estcbPJgXD-RRx4GjdcB+A@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc: Replace the obsolete address of the FSF
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@infradead.org>, 
	Thomas Huth <thuth@redhat.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Thomas Gleixner <tglx@linutronix.de>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-spdx@vger.kernel.org, 
	J Lovejoy <opensource@jilayne.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 7:14=E2=80=AFPM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Fri, Jul 11, 2025 at 05:02:18PM -0400, Richard Fontana wrote:

> > while this one:
> >
> >  *    As a special exception, if you link this library with files
> >  *    compiled with GCC to produce an executable, this does not cause
> >  *    the resulting executable to be covered by the GNU General Public =
License.
> >  *    This exception does not however invalidate any other reasons why
> >  *    the executable file might be covered by the GNU General Public Li=
cense.
> >
> > does not seem to be in the SPDX exception list. It is very similar to
> > `GNU-compiler-exception` except it specifically mentions GCC instead
> > of saying "a GNU compiler".
>
> https://spdx.org/licenses/GNU-compiler-exception.html
>
> is exactly this.

No, because `GNU-compiler-exception` as defined here
https://github.com/spdx/license-list-XML/blob/main/src/exceptions/GNU-compi=
ler-exception.xml
assumes use of the term "GCC" rather than "a GNU compiler".

Richard


