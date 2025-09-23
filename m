Return-Path: <linux-kernel+bounces-829320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFF3B96CC2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0C2416E2DE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97570322A0E;
	Tue, 23 Sep 2025 16:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYlLQxu4"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7858F3191C8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758644467; cv=none; b=hbh68ISRjGM+qmT+vO5F30p3wfLaBwCQhk38h1VHRgHLFagiozRZyUxSl1WT2/hfmjhqXknjYv9rkwnUwj3R1UoJKpszjcYiQtBlKlEDl9zuJpgxviju2Db9SwVv5QWdWj8/bswc88/t+8lR3g9T+tV7+x48BgpO9dJ0QTdZjaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758644467; c=relaxed/simple;
	bh=J0zYrROHm59Kv9l2BgsGDceHqwDg3Z4R0dFjaeHFHxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTlTzYpW8Z2joWzvCAUgY8Sn5uUpcbyNogctaFh9lqV0Hs6V02QP9HdzaU/r2gVV42//29MRUidRERT6lHZ7EDzmICLAJbIdiWZdqPwe98WqRQaM77JW5yUtwrSX244ZAiUKuVMYhiupHZLNSPBNXWXLByvVJibdW5wN5m+iTSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYlLQxu4; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-244580523a0so67621615ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758644465; x=1759249265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wnl623znH7NUrxrG7pcJc4egYSbH0ZUgSosdzvmTRxI=;
        b=GYlLQxu41QDtn0MY2Y6kf555vHpDfdBb3Tyosudu92UmJe3Q6aDuCpl3MqPzPKlHw/
         Z99u2nb07FpxCzjDCDu6LXX30FPHW+TDQL+V19ffXdyvTD+gZBfQ/63Vz0+wX8w6K3d6
         7TCpGfQOxHXht0wToVOGVSFdW1krFshqZNxCzh5h/yuZgJg54GqCOq0j6w+2+eUcbd4h
         XWid+DL/C8EGluPwh2SMAHBBbgUDAxx2wvyebmMpZOvKiKTIiHTtoEID+otNLLBtCPQy
         MZXf82fWfEO0W4mN8x+ag8Wp8PGwnd/Xzd88D9CAcqJpRL7Q70Ogsut7p6FCbRdw9B42
         yreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758644465; x=1759249265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wnl623znH7NUrxrG7pcJc4egYSbH0ZUgSosdzvmTRxI=;
        b=DsWktdxtj1O1JQNlXXFHjQ8BtxHw12Dy2+34OnOTgun+edGQJBt1Y6msi5Je+f1gOM
         DRdXKKWU3szQN8s95KrbkyCa6hbXjGDCkgO6y//fqQQ+qBT5Bqjw9Niu6UvLEB6mOTAv
         FCgA8dJJD0acJTMmvQgTAObUMUFpL8heqKJIRFQrV/1yeNIW/iKQ6M9l1IULqnaJGAmJ
         xzq4HCeC1ttR0d8G3I6OJOimlewcDkDSBSOWPf9qfRK3zVC9DmeLclLH//qZXtQnrFUL
         i3gXhUVSpyjr5SobaTfa2hwIGUVtXiVJVtjfrD2uA04w7q4vNAAyZCWWzEPSqpmS6JSg
         wlkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaknYBIP+vncLQdmDnQTEIieTSu1bAYV2oDVpA+qouSK93zdrNlDVHitS8SC3tpkhvVQrlop0TnETM+ZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyiTTpnaIgRav6Io4wKTb6NxbaDnsxeyujPdhNEhZSWH+cRJX9
	siF3ZqRFQtnSw5CyfYdkPHHvnc9AMDKuAqN/OXLx7LHF3ib2gb2jon4o
X-Gm-Gg: ASbGncsEwJYU54V3YeEXPQ6yvCDV+VnTkXMeHyNTA0ACfcudR0/XPmFyjEKgQ5yYWoo
	2BKU3kWquSU9oMD5TFQ+M6DFG1PxNE5ex89AsDupdAcFJkihWLbqxx/QWB80SAerrLA2yjwh4Tb
	oNFmGJS3SdKR6cbrqsd+ZWN6wQF/Sm5gEt6STHMNHtxZ+2GEAM6i1A8SVkg1tO9KThMAwIH8+1D
	dQ9fbSgWti5iciVh/HI8b6Wo1IBJbQIGXJwn4Zy4Bq9vo5gHqLs5E3f2E4hrbz/BbjQqoDWa2v6
	gHXv6P/XTnYvyjyayeSd0jtm1DsG17yOw5BXJl+azsMrWExqO/DfnPrCdNnNhHOteEpqE8Nufak
	QpdAQp87nlZTwxnrLNT8Ib8ZGFmUxcFuxJBLeFfOU17MK3b14HQ==
X-Google-Smtp-Source: AGHT+IEzcSrcbQzqmk2Gk22qQe56jWZoe9278D+hOsua5qVrCgwiGLfCjvRMvJL9TlZTYKvN+ny7Mw==
X-Received: by 2002:a17:902:d584:b0:278:9051:8ea9 with SMTP id d9443c01a7336-27cc5fcdca3mr37291175ad.40.1758644464728;
        Tue, 23 Sep 2025 09:21:04 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698035d337sm162975475ad.139.2025.09.23.09.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 09:21:04 -0700 (PDT)
Date: Wed, 24 Sep 2025 00:21:01 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: ray.huang@amd.com, gautham.shenoy@amd.com, perry.yuan@amd.com,
	jserv@ccns.ncku.edu.tw, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/power/x86/amd_pstate_tracer: Fix python gnuplot
 package names
Message-ID: <aNLI7VBQc+NFrmo8@visitorckw-System-Product-Name>
References: <20250824200902.163745-1-visitorckw@gmail.com>
 <75046094-d3b7-49da-af8e-3747ae9ed272@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75046094-d3b7-49da-af8e-3747ae9ed272@amd.com>

Hi Mario,

On Mon, Aug 25, 2025 at 04:25:58PM -0500, Mario Limonciello wrote:
> On 8/24/2025 3:09 PM, Kuan-Wei Chiu wrote:
> > The prerequisites section listed non-existent packages
> > "phython-gnuplot" and "phython3-gnuplot", which may mislead users and
> > cause installation failures.
> > 
> > Update the names to the correct distribution package names
> > "python-gnuplot" and "python3-gnuplot", helping users avoid confusion
> > and saving time for those following the instructions.
> > 
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Thanks for your review!

Since the merge window is likely opening in less than a week and this
patch has already been submitted and reviewed for about a month, I
noticed it still hasn't shown up in linux-next.

May I ask how we plan to route this patch?

Regards,
Kuan-Wei

