Return-Path: <linux-kernel+bounces-824162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4458CB883FA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33A661C8747B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AE32D3EF2;
	Fri, 19 Sep 2025 07:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBGigD0c"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC772D3EDE
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758267923; cv=none; b=ieTd0EnGvXITwtf5lyE+NTt6z1g244ZrBSOmSTfg4+fj47fBPdd76iA8NVoB93LVbVOQlAJij73vNi4SAhDf7oBOMvHuZOnD+2IVaoXZtmtdRSJHUd5lDCOkhVpcVSYTVE1NBL2DVsf4/RP/BZaqGIsxJauiHkUZqVkI5wVNMhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758267923; c=relaxed/simple;
	bh=G5NCxklBPHy4efUUiThtpcKjg0wPNcH+CK6EOvnsvrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPcslsVsu6XsowbFL5GP5H6L6+Mth49WAZ8cq4WfhX2pE/ZQbqrln0tWIEIt6wxNo/idNtV7/LV3/d+Uz/TLzH6gSMETFcrde7CfsOVQHjiL3cKsLumwJkd1e+6I5lKm96IUHYfwaNqAzjZLyCqbm2oWbAwmDuAckHGwtraDNZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GBGigD0c; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3dae49b1293so963416f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 00:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758267919; x=1758872719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PNMgvIIFlPxMgwjf1A0nfVZAfJVYlyoyJvlDVyQp+0I=;
        b=GBGigD0cljP/rEOt78vhsH2aVfMuQcqMM+HQAqBJLoFDAPsfDGAfmT0fFIwcRnVO0B
         PNfwtUID7/+c/KYLqz71vHLsY5Dz2S8ffwPOfWkOY6mTbKtc7wzneCnueD3a9TJY96AQ
         6j/OWq20Y21eX90IHt20lRkFHO8Hzcm6Djc7odLkjWE3JUPDDqdkEBb/HXNnI6sIEukD
         i51cBaepc/aS6DE35g8qkYdy+Mo9KwCIvhQWJEAFEsgDHaMhFmKFuGeDKHKoN4/9zEw6
         tY6NRV8ZGRLRx0Kfy0P4lesSck6sE2A1f86NgcxTBPh8p38fsSRV/6A2PibIyCa58GX2
         MWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758267919; x=1758872719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNMgvIIFlPxMgwjf1A0nfVZAfJVYlyoyJvlDVyQp+0I=;
        b=mtF3heeuj/KUzxNRlQAntSPvfOGbFmaKZcCAl0WTSYPBAcs03Zo5uIWpru6RxhIP2Q
         Nk6aDnVw6ZeHh2WBrCv8NYCIYHR5sM30e1w9+Yvg/Pk2WiGyzPFVgKS//HLygqx/v5D1
         i+w5dLP+0a0lTg6BY8A+9yYF6pEymIiyh60L05Hw7g/tsgUOULbWTx77xy39NT8lvrU9
         ldEBNCHTrezctIDoIgTbPrYiOrZTW0pjib0sKbav6CJeJuqhSytAIbhCpaJc9iMdxc68
         qJFjtxo7OL53vOHu9I71ujktBrFcRgKuD1dHYEMLsM2R3tst83HmJEenEa7SqiecbPwf
         pZ6A==
X-Forwarded-Encrypted: i=1; AJvYcCVmri74+tjEO1KJM06QCwMRx0A6Ep87bhF8UIdc+/v78EYGkvh2Tarcxx2lXabXoyMgUE7njsype/StVaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YysGvh4sCVRirBs8BfIm1EoPpN3aCa4pibtFe8Eyc6POt9ccLhy
	ikFrl26QWAGTjyZc6eeaMgs/tvol+46eGC9RYseYBruiS0F7dH0MgI+Q
X-Gm-Gg: ASbGncs4mIG3NyjS2XbetzIO76cWZnUb2wPr2WcW0cSO7PzAIZ3rDnJMvkDEE/ZSAty
	08aAylQWM3zIEPdnltrLl8rkIuKLjXckz1ZjBJHr26Xh98MNR1UHb+qTH+YsNiv9ZnhXuZ4vFO1
	jmrHLHBYM6NLLfT2SYMAXuLzb8pOvQCBO9y66D/uT3tdTi+I+xXfujHTZo6KLnmq/Llfw2EHb56
	j8+PAo/cudiNwnvUMcrGIHqyR0i2cD9H1Mk1AOX8T66wel/yGmTyhON4MIvcG7UW5oVmAfPSTzr
	rW2kJ7601ru9AV85qlJZ+pk25i8uSgHimNEDoMpYjuqKpB6+sayUh0ksmKLxbX8H7VwyV2WRAGT
	e5x83nhWmAmLoQLCNgci6
X-Google-Smtp-Source: AGHT+IG5w03VkX5w0L+qmk9oTgo8UMgIyxUlqtHb7DAa5eouVlBho3WcVeCjzVUkdw6abcur45ZJQg==
X-Received: by 2002:a05:6000:25c3:b0:3ee:1586:6c85 with SMTP id ffacd0b85a97d-3ee8713efdcmr1612059f8f.57.1758267918368;
        Fri, 19 Sep 2025 00:45:18 -0700 (PDT)
Received: from andrea ([176.201.192.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f3211e8c7sm73637115e9.3.2025.09.19.00.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 00:45:17 -0700 (PDT)
Date: Fri, 19 Sep 2025 09:45:11 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: Guo Ren <guoren@kernel.org>, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, ajones@ventanamicro.com,
	brs@rivosinc.com, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	apw@canonical.com, joe@perches.com
Subject: Re: [External] Re: [PATCH v2 0/4] riscv: Add Zalasr ISA extension
 support
Message-ID: <aM0KBwkdPFD69oui@andrea>
References: <20250902042432.78960-1-luxu.kernel@bytedance.com>
 <aLciY2putG8g2P9F@andrea>
 <aMoyntAydNMtcl+3@gmail.com>
 <aMw3504EwlnDOJI0@gmail.com>
 <CAPYmKFt=5=t_nxY4FadG0_vSgAu1tXyO15OCvo5x6QorqM+BAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPYmKFt=5=t_nxY4FadG0_vSgAu1tXyO15OCvo5x6QorqM+BAw@mail.gmail.com>

> The existing implementation of spin_unlock, when followed by
> spin_lock, is equal to 'FENCE rw, rw' for operations before

This is not true without Zacas, that is, when using LR/SC: write-to-read
remains unordered in that case.

  Andrea

