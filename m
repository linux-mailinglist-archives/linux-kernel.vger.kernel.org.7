Return-Path: <linux-kernel+bounces-806709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CF7B49AD3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 22:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44B5B7AEC92
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CC72D9ECD;
	Mon,  8 Sep 2025 20:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aYSYMBnh"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E2F1A9F93
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 20:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757362618; cv=none; b=QtIaZGD3Fbxr3se8xeMwk8dBUvzKJFDVfuyip888vsP6PbocH/CTCzf19VYQGJoTyvH6vOq1uVz9iKwX2RBrRFtxzdJ+LdLHP9YsxrDkvLdukF7IVI58McSOTBXa7+sTY3lU57qyY4QzkpifXePDtBlYLwzKD69pJVEU422QSAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757362618; c=relaxed/simple;
	bh=mBaws8il8SUlA6WSSLGfhI9qLX70tcq/5enQocS4ayM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xzp2Xw89aZMcdmMgxC7iFh/J9UQiANeWCBS9EYtfJLDDP9ylhbKfO8JaRyPR70ifecPi0Mf+0+MRpWXU1W+yoqiUGsqWWGaOm0GZmYjSvH8xpHi5YF0N5gjFnmyecAwPxYEbYegeh4g8foywFTSZ8UaqGYaJP4OQ3RjWx7NL1Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aYSYMBnh; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24ced7cfa07so46870105ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 13:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757362616; x=1757967416; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qfpE52Gqw2W2qOIF2LEWUdlTiZrgbTClWQgTw7V+KY8=;
        b=aYSYMBnh/oqW479LSXnZa8NBOYIuVwv+Gi0AC1YfhcHj7WACdVo+278sVJ30Ax0l/T
         J1pMV27Cvgb3eXcmL/S4KoHEuc6wBLnQ1mQyjehWOUxUQPn08THKp8p0OyNP8BO8RP/V
         UJhXEWhUEGotTw9FO4jWGRLRN92zncnXGS2Q15xFSKU7fGStvLo3Rb69sqLINBWTblBD
         qx4kQOwtfXjsHKtMo4RARVBOyYTm+RszZTNrbLl1cIRdTEAvoesr8Oaww0cbskl4KLzD
         4pwfq+Vnmx5rWv7Gs5QqbIedw2/ROEPzSyV/RPaDdMNKV4ff+zFhKTuInUXy8pdEtyX0
         HCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757362616; x=1757967416;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qfpE52Gqw2W2qOIF2LEWUdlTiZrgbTClWQgTw7V+KY8=;
        b=L0oGT0h7lGkeZNZoycDGRVMTX6wbWPSK2zg2DYvfXG3GjhAGkJ85jbYr0wgYuwRfI9
         l/ziq0ZNyW/33qqgbDRhsFV/myxDxkJsPcUQYUurfEcsxTWHAaUZlEXTC8GYo7Wit7MY
         hl3DnczsfspzuJuTcv5aDIAbtPG3NLn7OVmjUa6Mfbg+FfWR5+9AqBG8nZUJm9ROHe0T
         UIUk5Owz0JW7LSlT2XGJmAnxbiOw44/AkN1bogZ3lEtsYIJQZcGqFFYS8NHUcgERbWMa
         fckLrOl7tXIMFwNe2Fr6AhHbjzEabXKacffmm/7SSUL6tpf6G6gAZ+6NV+tKsRn9+b/6
         agVA==
X-Forwarded-Encrypted: i=1; AJvYcCWt45Dw3hIJu4gHbGSoEl83yD2vnwiNIGX4Ra8r/zAneAn63V1njRUn5SyFkwWorGhdaEdmtSAJ1TSMw9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeAX2G3PmVIgiJt86kFwO9hR5FVIjBABgRwXXXKtjpiRgjBQkj
	Ywo4piHS0ZtIxOp6QY7vbrGgmYdeVp5xFzoqs8YrQaTCFzyMg974EFBrV1X10dnql73RyTH+R6E
	X6KMhVw==
X-Google-Smtp-Source: AGHT+IE4Uz4aeL1CzrhdbWXCrjzRFDnmBdT6CWeiwE54bJsWIU6/UxS2chnflOdmVd3uAXCExvexqh0uWAM=
X-Received: from plble7.prod.google.com ([2002:a17:902:fb07:b0:24b:1589:e332])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e94f:b0:24a:fd5a:6b58
 with SMTP id d9443c01a7336-251738ca0demr121146205ad.50.1757362615512; Mon, 08
 Sep 2025 13:16:55 -0700 (PDT)
Date: Mon, 8 Sep 2025 13:16:53 -0700
In-Reply-To: <aKBPjfyIHMc2X_ZL@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1752869333.git.ashish.kalra@amd.com> <aKBPjfyIHMc2X_ZL@gondor.apana.org.au>
Message-ID: <aL85tQ2mm6d2PqSx@google.com>
Subject: Re: [PATCH v7 0/7] Add SEV-SNP CipherTextHiding feature support
From: Sean Christopherson <seanjc@google.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Ashish Kalra <Ashish.Kalra@amd.com>, corbet@lwn.net, pbonzini@redhat.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	thomas.lendacky@amd.com, john.allen@amd.com, davem@davemloft.net, 
	akpm@linux-foundation.org, rostedt@goodmis.org, paulmck@kernel.org, 
	nikunj@amd.com, Neeraj.Upadhyay@amd.com, aik@amd.com, ardb@kernel.org, 
	michael.roth@amd.com, arnd@arndb.de, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sat, Aug 16, 2025, Herbert Xu wrote:
> On Mon, Jul 21, 2025 at 02:12:15PM +0000, Ashish Kalra wrote:
> > Ashish Kalra (7):
> >   crypto: ccp - New bit-field definitions for SNP_PLATFORM_STATUS
> >     command
> >   crypto: ccp - Cache SEV platform status and platform state
> >   crypto: ccp - Add support for SNP_FEATURE_INFO command
> >   crypto: ccp - Introduce new API interface to indicate SEV-SNP
> >     Ciphertext hiding feature
> >   crypto: ccp - Add support to enable CipherTextHiding on SNP_INIT_EX
> >   KVM: SEV: Introduce new min,max sev_es and sev_snp asid variables
> >   KVM: SEV: Add SEV-SNP CipherTextHiding support
> > 
> >  .../admin-guide/kernel-parameters.txt         |  18 +++
> >  arch/x86/kvm/svm/sev.c                        |  96 +++++++++++--
> >  drivers/crypto/ccp/sev-dev.c                  | 127 ++++++++++++++++--
> >  drivers/crypto/ccp/sev-dev.h                  |   6 +-
> >  include/linux/psp-sev.h                       |  44 +++++-
> >  include/uapi/linux/psp-sev.h                  |  10 +-
> >  6 files changed, 274 insertions(+), 27 deletions(-)
> > 
> > -- 
> > 2.34.1
> 
> Patches 1-5 applied.  Thanks.

Can you provide a tag for commit c9760b0fca6b ("crypto: ccp - Add support to
enable CipherTextHiding on SNP_INIT_EX")?  I'd like to apply the KVM side of
things for 6.17, and would prefer not to merge or base the KVM patches on a bare
commit.

Thanks!

