Return-Path: <linux-kernel+bounces-853737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9BDBDC796
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F118F3BF1DC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 04:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2222E7648;
	Wed, 15 Oct 2025 04:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYcvpLs4"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F408F1EFF93
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760502676; cv=none; b=jpOpH4zXMGpzaknZg5ZE51MA+qdQmf5tlevwYTv/m4jgjX+wpdeM/ARbgBzdS6LhsodVrA5nKj7wynOXdjUCxGbZ7SUzh+GH99/ANXB9QpDQCUl+4CEfbj9e6d8IGZGZfu5adMz7tyCgFHyxBzCBK5G37EcmU+43Fp8iIB6+hdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760502676; c=relaxed/simple;
	bh=WZDuYxIjoxmC+VGiYmi0zZZTyaYsaSjEDxMqtDZo/e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARr99a/cch0zRBXAhfxg7Tna4V9pW0/FLm7QfWknN9Sd36HTX6Yq8w5RounIZsYGJaJjiDNJbkvaz1lWzX5ln3RVmaVBdpIKMo2sr8Wa+Qw5je9R3N8lgXDN3W/ww6UTYaPiU8yqGao1pdc4FA4MyKbu6eeK+H1QPDvjq39hC2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYcvpLs4; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-781db5068b8so4844586b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 21:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760502673; x=1761107473; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zts79kuN/IJCAMCcBE3kS6G0VPd2KnMSc2XzegRhv7w=;
        b=fYcvpLs43kZ+bmg0oKnOUyfFzXpYH/WsqPVXSkr69oPcjfm4+Imj8wEsdkLd5fTcOA
         pQBfPYGUPRksA1b30j/zS7ouw00KuxIBmSCwtuOsnyE5IECU5woH4kEuTY+db6PZnRtH
         flS1MPWN0J7X7Jk6i03KnqiUXSpqHrFhpGI2944bfCFWsD20+rX6ZyygrOpKQP9v8X5D
         lHcPr20gVibgFUxI2v632xbNDI+bK5Rv3O1sF3KXMZwmJixKb4cpErZSmMMnrASyGDFI
         0eNHSWfNc7KC5sHZN/rvX4+E02evq+vUhG552saKUUNyutRwnaZNRUbHuGOJ3DLl3f8Y
         kxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760502673; x=1761107473;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zts79kuN/IJCAMCcBE3kS6G0VPd2KnMSc2XzegRhv7w=;
        b=i9W2DSnbKB/NTo/Imgw0aa/YlcgsNF+T+MFXZlRRajjhDWBlRkE3IBLqLwTYx9ESjA
         AF4sGxxCrujK35FQFg2q0ijBnofFj9v4D0gu5fSKhWMeMzJqhiuN5eH+gxff3vIUHAMP
         EY1mX//aicZC43VkX9Fr3FHvbAQnsihpo1dXamVrwbvhvEa4JGbsond+BKOPoPFl/FE6
         JTemBU5akKCKqDOnXtdCEzqFmoFDJhMV8GPstd+i5y0AW7CB4XkPeU+huAMUgBNFewHS
         sT/I3f9hBEgGvLptetFSFd1BJgbLvRnruFEI9hhNf0o5MBG6/7iWuXSMpXmXs9AlUXhw
         Z4JA==
X-Forwarded-Encrypted: i=1; AJvYcCV3JY57bpfUkr+QcZscNIgPD1SV7llaWUxpwSwCzFLDSPk5yqzConT7UT+fdsIGwkRTCKUV5720JNAp2gI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4SLy5kH0zqferoMdH4WTBDix7k4dGBexFjnOiEFFJPZsMnnb3
	oW9Ql0FsFE/bkeCw7Im7WPxZq7lxHvI1HDWwgqFXK8VSFyK6sFY5xbZv
X-Gm-Gg: ASbGncsdVT3lhkaKqIL1hF8NkFKhFNledan8I2Xv8ueKoHH//2u4uQBGwYmAPn2wcDR
	mfBA+6aRq1gQpYlB7MuICsGtyNo5b4qkyeEVTZE3prIArOYW6/CGXwPZS86uWwRR1MpQyQB4w53
	sFTGoSHd4Dj7MG+nSdeuVBESdOwkzlNbs2V9FnbmrDpshCOPGn177taOEs+FzLcihVeGBACgGwH
	NDmWr2LYpXOkRzUUzS9M2q9xbQj2FTcx6659mH/EyFn5x7JSvDJnEeW2HKAvolDfRbUwyTNfrYb
	V3LK/S8+fPfS/lJ89qu5IXiqQXe4ohKq2+/tmbhtrZygqAmVSk/uKAsv1+UmCoq+9pU4JVUeb5S
	Bbt5Mp615WNtLVqtgiERpoNha/Tw41dqaSbraYHEFgYRnpH/3vsVQ/ofs56wDZAyEUcTrM9L/Rd
	aJ9oLAPA==
X-Google-Smtp-Source: AGHT+IG6FhMTeWkEH9QZHgmRQ8kee57qbcSb2Gok0oXxXlAmHWNH0ugczjyMBwNxwo17qCCsOZtnkw==
X-Received: by 2002:a05:6a00:8c8:b0:781:27a7:dd0e with SMTP id d2e1a72fcca58-79385ed5786mr27588710b3a.9.1760502673174;
        Tue, 14 Oct 2025 21:31:13 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:729e:7380:f286:50df])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d993853sm16835038b3a.74.2025.10.14.21.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 21:31:12 -0700 (PDT)
Date: Tue, 14 Oct 2025 21:31:10 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, 
	=?utf-8?B?5Y2i5Zu95a6P?= <luguohong@xiaomi.com>, kenalba@google.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: hid-input: only ignore 0 battery events for
 digitizers
Message-ID: <nsz6llo4nsg4zuiogmewuccl76nzjjijgkjzqeazzs33lj4phc@k5rskuabbsz2>
References: <of5qjeij72wduee3zyf26drfcwhpsl4sjs3v6tfjv3tgl3xsol@sss7zcyawwaz>
 <r20q42n6-n65r-3151-s194-10222o3o6s6s@xreary.bet>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <r20q42n6-n65r-3151-s194-10222o3o6s6s@xreary.bet>

Hi Jiri,

On Tue, Oct 14, 2025 at 12:25:25PM +0200, Jiri Kosina wrote:
> 
> Hi Dmitry,
> 
> thanks for the fix. It doesn't apply cleanly on a reasonably recent tree 
> though, as since e94536e1d1818b09 we're already propagating usage to 
> hidinput_update_battery(), and we're issuing explicit call to 
> power_supply_changed() as well.
> 
> Could you please refresh on a more recent codebase and resubmit? I could 
> do that myself, but I guess you also have a way to test the patch with 
> your use-case ... ?

Sorry about that, I made the patch on top of my tree which lags behind.
I just sent a v2 rebased on top of linux-next.

I actually do not have the hardware to test, we have to rely on 卢国宏
to do it for us.

Thanks.

-- 
Dmitry

