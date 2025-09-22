Return-Path: <linux-kernel+bounces-826790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A86B8F598
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8373A1883500
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 07:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38172F90E6;
	Mon, 22 Sep 2025 07:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B53g+eii"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54532F7AA4
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758527681; cv=none; b=BYYbaM8F19kdUO0FsFPkLoaGAl7w7jc0EjY9aalWyHiTgajtwsclds8KK2+XdwNIuhQUerDnyrcUgF8XLloTc3WVYKQwGXgtTsxxYYeCY/xfCrzY53CDSR288hfcNR18lhgoW323IcJvAMFl7vUGZTxQnt3P8KOiuLU+U7sBvxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758527681; c=relaxed/simple;
	bh=wHhXbBUv8sLtLk6ZtdozUkZSGPHqvYUTRhRTVOMPPw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=liN/ePV5wjrvCHzCzD1ukmEKCsy7K8UYBxD4Wr0e8HrQ26y1nSZLARgAThVoIP6HzfBGyPnSxkP2goeCLnZH/Lv9zCG3uKw47Fiv7wC35bNZii93EVRacPn5WTgFsaMdmyzWre08TQ4vHylgxwlmaaJ9gfWBu/L72hge8U1dNes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B53g+eii; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2445824dc27so43155685ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 00:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758527679; x=1759132479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wHhXbBUv8sLtLk6ZtdozUkZSGPHqvYUTRhRTVOMPPw4=;
        b=B53g+eiiTb5GDiKWZd/72tvC2vLjAUOqGrQYYHn2hP6zqCOPWTErNP9eJU1q4+a/Qt
         nL2Vs9X5i9mVdn1Pyxy8caliAFbGYzbaF7JFqNAg1lNiOr3b5sq3uBRtzxY4DtbA2Nge
         lZPVjDf9YW9iKP6TBSRl3pKL4xYTUIju3wH9Pb7IAagjLzpGzB9R/deQZsblrDLnw4tZ
         48iOLBZlT6ZK+DwHPH8ZRpmUFCzPRzbAqu5ux2Cn6gw6LAUdDKHFSXtE/h3lkJosoJwr
         LkRD09lFr9kXwu453ADEQaTiKiuozO6aJpudEqSfRiUnSk1qUAxKi8t2ptYTix8/TUBx
         bpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758527679; x=1759132479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHhXbBUv8sLtLk6ZtdozUkZSGPHqvYUTRhRTVOMPPw4=;
        b=AonChYW/mZAVMKdVS2ZJstgqHTY+8FfIOyhHYrvcdtN2ZE5M44grPy1ql2czUzL1c9
         oOjRhDdHmfBBg1G5QGgefyU2AId9ByZJbrE8OrYMS7yHkF0QrgYS66iHAry8qoFXEOJG
         nWwA+1EyzB22egfb99Tfd8StCCjDH4gsoz9isPrxe/HU0xm7zjO6JmjYbnTlm2VoVmhf
         8oJcg0TZ/ivKzvuqdUre05OZfCE2uhfrU43JGck8VcAlLOjT3VSP4TCgfdpoKGEPySeq
         bQpFngtWmRfWwqGEkdLh1UVP516ivrwJI6VMm4JrjsJEuSaz9PAJqllqWAbECjbajxKO
         83sQ==
X-Gm-Message-State: AOJu0YzzXqu/iMq/v5sK5ii7HfXmbFSLGUjde6WjEc5jP/Txj2RAVPA+
	4n79/DCnQ40ZH+YrOitE0ieLrYznRc2kqdVAwhSmYC4dgOzBcDSt8wyM
X-Gm-Gg: ASbGnctc0Ltaf/M8dNTUswwKdiSlcKdMA1EOnqrK7J1fE2ZPuW05x3NNFZBFtEwyBI1
	m3nvq5Tydra20anosZ2iypCZYHZDyT0hUhNjqeKBVgX7lLD1hCJ9exHv7UBh6mwNjpuWDfQzvvR
	fGgvVX6C2dxCCPwD9Ha0FbgtxQ19+XAQ76YynC3RV4lP6J4u2H1w3eE2V0CU8+mspKdr730msp/
	VcOzYHCNypEBLgxcAvdmeX0rMROSGM0sSgDFYLcqEYtNncSdjB/YcQJkYQAOXWzIzJC5lwprRHN
	fXQOckByrtrIU3Y/6u+UZWa/P+vC0P5Fg15fvvZUElKQH5LVC3L8b2kMgzccmajex8dFbpNgVXF
	oqUBTsds6KdaIeT5SHkbWOQ==
X-Google-Smtp-Source: AGHT+IHz3wNSWldGNXV3xlynWhX7Cr9eYZtSb12u2x27WnJQYglboQKton+MwFy1y4rS6oR/rbqndg==
X-Received: by 2002:a17:903:3846:b0:267:c984:8d9f with SMTP id d9443c01a7336-269ba45919fmr182012075ad.24.1758527678869;
        Mon, 22 Sep 2025 00:54:38 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26e2046788dsm71684115ad.72.2025.09.22.00.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 00:54:37 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id D26144220596; Mon, 22 Sep 2025 14:54:30 +0700 (WIB)
Date: Mon, 22 Sep 2025 14:54:30 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux KVM <kvm@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Wanpeng Li <wanpengli@tencent.com>
Subject: Re: [PATCH] KVM: x86: Fix hypercalls docs section number order
Message-ID: <aNEAtqQXyrXUPPLc@archie.me>
References: <20250909003952.10314-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6Hw9PxwxK+FTyenQ"
Content-Disposition: inline
In-Reply-To: <20250909003952.10314-1-bagasdotme@gmail.com>


--6Hw9PxwxK+FTyenQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 09, 2025 at 07:39:52AM +0700, Bagas Sanjaya wrote:
> Commit 4180bf1b655a79 ("KVM: X86: Implement "send IPI" hypercall")
> documents KVM_HC_SEND_IPI hypercall, yet its section number duplicates
> KVM_HC_CLOCK_PAIRING one (which both are 6th). Fix the numbering order
> so that the former should be 7th.

Paolo, Sean, would you like to apply this patch on KVM tree or let Jon
handle it through docs-next?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--6Hw9PxwxK+FTyenQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaNEAtgAKCRD2uYlJVVFO
o3wKAQCS3n6Xj/tW8RTpqqfFhRw/RaeX1a+0H1vnroXuIBgyAgD/d3RMhZPFm9JN
FhRV0MeuKVEwYkg2livKKUt+Jgs+lgY=
=b9qT
-----END PGP SIGNATURE-----

--6Hw9PxwxK+FTyenQ--

