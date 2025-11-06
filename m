Return-Path: <linux-kernel+bounces-889647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 62232C3E237
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 02:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1780C4E4727
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 01:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86152F5A25;
	Fri,  7 Nov 2025 01:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azuCJLZD"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977D12F5A26
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 01:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762479235; cv=none; b=PxjZNodJ+uy7/Ojeh01g6TcGjvwy1x17n9+pFUt5V5VOyqct5YHuwx+6DKK+PHW5R9RT/sruu3QYRtGKoCs/w8TIzqwTepc/QhyWf/ydaEp42RP9AMSoEVHnxjgV+yavReE0Hut1Q2Vx9hXP55IVVRDBp9eqQ4znkiUUNu1xcE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762479235; c=relaxed/simple;
	bh=s4//rXzDBRVBNwADTTn5nejLJJDM9DaWd5NHxwgbfFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vBfwqhafmimvKGAfXTq1GF85mv7C96Hqu1w0Ztalwi7Z9VufI3VN2XbrBcDkxesN/ux9Y/jAM8/FR/OHrZHvtukHXTsPcXdn0HVF6/ukWalqmGotqLLXTOwOxfmg+v1kHoPVH7+us92f7bIuiamngWhluEzTPj8sKy/x76rlr+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azuCJLZD; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-640b9c7eab9so436020a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 17:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762479232; x=1763084032; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s4//rXzDBRVBNwADTTn5nejLJJDM9DaWd5NHxwgbfFk=;
        b=azuCJLZDrK7XHpNTBl5dUynyjRxkmd7I7TaFfGN4CTX4slSOY0jvJXksqcGPFE8Pyz
         psRfUu/H4av079oQPJdR0COdE9nr1Kves2VsOzHSYN+IPSH6w+ijJ14RyjCzYV2qt3y/
         0y6RGdxbmn9v3/ltBV842Lvzef+CLhzNDpKsWIO3uWElYrMv7XF+vTcBr+jHKk8ljTJh
         iYbhWSSAlYtMy0rtouzjCYb6XG/ilzu9ibptsIfCeY/eqiUgiqedHxGurR0XjnSC5ZFb
         GmSqfEF9E0zSa4Hp+LAeYmA+7YiKOaLXrJvy9C5VIZLpEetvBk4GaDnwdViB/JXrriTJ
         hmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762479232; x=1763084032;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4//rXzDBRVBNwADTTn5nejLJJDM9DaWd5NHxwgbfFk=;
        b=eddRpQ45LPVc34e2g4yKM9bSyS0odi3XLrSaLPWtfgsULLGb25EMBdrjAA6DjTGtNh
         oPox7asoB0EXv6ZpQo/pnOAy1bEp0be3wCNLUGTCdF7txBafWpbi2wJgGgvJZ7FQWyno
         XFDiisxu00+WCEbw5EZXLJTZ7H35qgVSd+hMwsaTr+F4kw3CgnUHO0HL0Q0fnS4r3IPZ
         8itsk139zETYN2z0VCi3un0TpMs3ISQ8HMzHVeXVKoe26Fe9b8N6U586maNY6tXe9243
         NC7rWjABtzjxH5+bexRmv0hM80Hzni885oED40qKd60u3/DK4NE+K+7GcjWfTjemzjGD
         88aw==
X-Forwarded-Encrypted: i=1; AJvYcCUhJaI/6MIiQR3NYktfO1mlr5GC7SLDYiTXxc63EZoPoV23oX+t/QK5rzh3GxTEGNvWpjLSha9/Za8AGjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZWscv/1A4SFs3avqwI29fKO2sc4X63hHSiJv2udzTzmmuknQx
	rvclyck4QoaWb7L/87hljxrOuVkz3ddHrrrboEdbmY7RCALIb48o8A7J+mwU2yDs7u+VedEx7uM
	m0UUOc+fM/FBn+fUjPjgIomABhWvtzaug2IHkkJPzLA==
X-Gm-Gg: ASbGncvnZh59tFTFio92vPbjnDlhOL8votVSbO7msutFLvpmaWk3POYg7FnWrzB5knD
	cmo0PPRsEdJG7kh9iZGxXSFF3FBIg5NNetWyqYdYUKGtY4JcKDH9OmPIbvRqcPfJsATyzePPIFN
	/uZukGciIp/0wn42qFE04HHWYYtTgGmZO40EooAAzoQcxJ1FZ7geCcWRU6buTVoW3YPIIgzMXlO
	YmcLOJwg5bE9bkyKh8FXjDRB42Iwtn261r/sqM23NqnRtZlui1HVWVcZdJgFuEDNmVYZu6irYuu
	BQQCkxrJcOKpDdQnNKnwBjSimpTq61dsrg==
X-Google-Smtp-Source: AGHT+IFs0p/ZshE8oSECFwYJl2O8ACKc9M/8ieJ8+hrmMK00uOd/hgBZgPKKUSuUkRJGeii5nbJkqvK+f3dDoKjW+Mc=
X-Received: by 2002:a05:6402:1446:b0:640:96fe:c7bb with SMTP id
 4fb4d7f45d1cf-6413f0f3f18mr1383801a12.28.1762479231677; Thu, 06 Nov 2025
 17:33:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028174222.1739954-1-viswanathiyyappan@gmail.com>
 <20251028174222.1739954-2-viswanathiyyappan@gmail.com> <20251030192018.28dcd830@kernel.org>
 <CAPrAcgPD0ZPNPOivpX=69qC88-AAeW+Jy=oy-6+PP8jDxzNabA@mail.gmail.com>
 <20251104164625.5a18db43@kernel.org> <CAPrAcgMXw5e6mi1tU=c7UaQdcKZhhC8j-y9woQk0bk8SeV4+8A@mail.gmail.com>
 <20251106141259.60e48f1e@kernel.org>
In-Reply-To: <20251106141259.60e48f1e@kernel.org>
From: I Viswanath <viswanathiyyappan@gmail.com>
Date: Fri, 7 Nov 2025 01:33:38 +0530
X-Gm-Features: AWmQ_bkJ2FriPSSvVAi2fzsx9ERxZ0UVfTFti4bNiLHi8cCqoPmyaQ1vev0pUMY
Message-ID: <CAPrAcgMtF0cKkJ3RAGbCPozcK7YRdnYOg_tp98kLsXb_nQ9ycg@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH net-next v3 1/2] net: Add ndo_write_rx_config and
 helper structs and functions:
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	horms@kernel.org, sdf@fomichev.me, kuniyu@google.com, ahmed.zaki@intel.com, 
	aleksander.lobakin@intel.com, jacob.e.keller@intel.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	david.hunter.linux@gmail.com, khalid@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Nov 2025 at 03:43, Jakub Kicinski <kuba@kernel.org> wrote:
> The objective is just to simplify the driver. Avoid the state
> management and work scheduling in every driver that needs to the config
> async. IOW we just want to give drivers an ndo_set_rx_mode that can
> sleep.

Fair enough. I will start working on v4 with virtio_net

