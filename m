Return-Path: <linux-kernel+bounces-819787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 263BEB7D68C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFAC618905ED
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 00:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29371F4C89;
	Wed, 17 Sep 2025 00:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fEJ3VkAV"
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228854316E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 00:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758069351; cv=none; b=NHqIV8GfJMHKZWjCSzL8DtVQwcIOilP61u0VHFA1cMNrgRTZdn6ZB0vdvmng5fkjegQ0jDuumRKsF7m70vFSs5DSMp3cIJpLgQPhoQLftKKgfzHFAo66BtWdS8nqpE7ryV68+XsV71BFneFHrjLxkz5bxYVRlWiEzyAwixLMDrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758069351; c=relaxed/simple;
	bh=L8phg8Yd0a8z0cJtU511m+EDzsT+ImjO6rzk1+SZ1CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qB2lOavXc5UP8A9Fp1JP/TDFGZOph02JHddb8S8QZ+n4ZKCW1fkf+0x2S8/uzYqyJ3ZbwD9JvyHC7MHf6A8W6q71btbjIpq81qrvJPs4mkkh6c6IMu5aLLgEqRP6BFz71Zzf18U6RamT661L36dGqKF5adfiueexTgU/1sPt0HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fEJ3VkAV; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-24cde6c65d1so53203485ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 17:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758069347; x=1758674147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sbI8L9M4JYXwDBQdPDmo55hFH7biVlrOkrfO/tfqIAg=;
        b=fEJ3VkAV4tAePxhBWANbdMBRIuG6tOVI/78Knllr+QP04AiZJ+nrBDvEp31BasMTyU
         Y+j0VBIwYVDV4CFVR7mFmoxpy0qfc6qZOR0+U07gnS+3AoPOmcNgzHMj/TdV2ED9d1hs
         4i3qthqegoY2NnzksO2tvsoI1Ocz3Ll72oayQx+YJiM1G/Qss+9Uv8INbY2VXEwYt9Dq
         m/spOD8I4JwFaeCKBgp/2nmynufp1WwGqaOhAArMNSR41C8DvZ4WITxgxjcIKrNtqNnD
         4IhOLHs1aA5uvX6I24dLj9McbejwiLLSyBRj3lU3AQkcLc6EhdOeLXTkFq9poEb4oMWX
         HsbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758069347; x=1758674147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbI8L9M4JYXwDBQdPDmo55hFH7biVlrOkrfO/tfqIAg=;
        b=SrQqkAl+SCGyEEV927KyVoLXWuD5aJZlCjvUZhw/SX1Q15Z0zMOGsba4KAh29O4fsO
         qXypIr7u91VQAB4RDWwEoGTKrTpiiKI88cnGxM7Vt7uE7BtzSdEKasfqED5zUXozKOmF
         hPTKP5KYtPsA9anVmGcIFJXmPvn0KnblvRIIw+hHdItEWElMwL2RbXOWT8oASeJraQ94
         6YtzTQvo/ZpKKryzJsQNM/1+3h4pSCARjffISY5TK8egxz+i9hxRUrRR2SJPel3pogjO
         K5ce+TCJTHAq4VjiVWr6nTlwkuzkPJZPfqO9qrg4HOs7OzEo/E1bTGOxSkJ3o76tNCgV
         7Sng==
X-Forwarded-Encrypted: i=1; AJvYcCX/oS+qX6czRkkfLLxtIEOU9hj0KmTxXj5OGPq+SBleJ8CFxhwwfubpuXg4Z02LY2RYJgJqg276QaCGvR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNVVTVyhOOcQQsShdvvV8V9bTT9xsFd9Jd8d2p4gYq535K3w4O
	rQdFkCBuL4Z8XAXI83L82JKtDCkEd6i4geaO9Z6nm6cw9T8klnFTaPEqCybnjIPv/nMTkd5XEV0
	UmZJAAvVQkel76ajYZs1w7Czqgx9HwGlM3Clq+le5E6jZdtSwS16C
X-Gm-Gg: ASbGncsyuorv47WlfKV4M9RuIG9ILb6Qxg9mEH3FEE3OEd8j/r1i7Ya/ZNWo7/fnTkM
	6oGUmRf8sMv3VuCBJBRVuaJIj/xY/5jkTJxe5cvxkZFgLAHxD/RI9/oyBok/65lN3ujvCwiUlyJ
	k0fIaPh8Wjqc8oLFTv2Qy1R9qg7Z+04OHJVymw2G2YNIDPrRh9rqXM8DvmOucoobb7hfI21kQLH
	ue8d7t50PZYHUPN4TQNDka0TomEjhK6I3jVOqFgyt9rh0H76rNmfToiTLCA0Dr4kp5GIrqZbZ9j
	EzeJ8kQcn3cEGjFwaZ9pyj+cazdHkjIVHOI9zH3SYWS4gn/9m5mu1cH4v94=
X-Google-Smtp-Source: AGHT+IEiIDXkSrx5GtdhuqYIDr1VIfuMjIQs0tgYZcUIgrXb9WrfiLPKfhN0RTcxZ2Cl9VKZoSsr0L7/MMXA
X-Received: by 2002:a17:903:3d05:b0:267:44e6:11dd with SMTP id d9443c01a7336-26813bf0cb6mr2254435ad.53.1758069347404;
        Tue, 16 Sep 2025 17:35:47 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-267b5deb158sm4934865ad.46.2025.09.16.17.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 17:35:47 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id AED7E3402ED;
	Tue, 16 Sep 2025 18:35:46 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 9240BE40EC3; Tue, 16 Sep 2025 18:35:46 -0600 (MDT)
Date: Tue, 16 Sep 2025 18:35:46 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: ublk: fix behavior when fio is not installed
Message-ID: <aMoCYseJUVcbC7gl@dev-ushankar.dev.purestorage.com>
References: <20250916-ublk_fio-v1-1-8d522539eed7@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-ublk_fio-v1-1-8d522539eed7@purestorage.com>

On Tue, Sep 16, 2025 at 04:11:53PM -0600, Uday Shankar wrote:
> Some ublk selftests have strange behavior when fio is not installed.
> While most tests behave correctly (run if they don't need fio, or skip
> if they need fio), the following tests have different behavior:
> 
> - test_null_01 and test_null_02 try to run fio without checking if it
>   exists first, and fail on any failure of the fio command (including
>   "fio command not found"). So these tests fail when they should skip.
> - test_stress_05 runs fio without checking if it exists first, but
>   doesn't fail on fio command failure. This test passes, but that pass
>   is misleading as the test doesn't do anything useful without fio
>   installed. So this test passes when it should skip.
> 
> Fix these issues by adding _have_program fio checks to the top of all
> three of these tests.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>

Please disregard; it was pointed out to me that I missed a few tests.
Will post an updated v2 soon.


