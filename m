Return-Path: <linux-kernel+bounces-891541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E8997C42E27
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 15:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7CCFC349A89
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 14:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175A61CAA7D;
	Sat,  8 Nov 2025 14:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtI3UR5x"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0019B2AEF5
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 14:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762611662; cv=none; b=aIWGRQe3jilWtYZJhp2KiId2X1GSY1m7inaRZoiVK5ZWoZcFVqrHO0QvyDtibFRUnJCoI/8AsoSFRfTzpTByk6lPNISUlRS+2E3C+feFZM2aMxUxt1TwXWPPlzdcORgcWBRvzIBV5yA2CPwMDoxg5rJOPBykBy6OmOaoU3O2gVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762611662; c=relaxed/simple;
	bh=ij1cTFyqZO7H3BNSWjRfp1q6pmZJMvuhnqWTP5Gmryg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=eyoXhnWUijl9M5fYyDgcF13CmzjbT3CX9Tiz4cOXflj7pOOQatSJLflEZH8JXzR9UM4SIW3u0QBB6it9IfSA/ntHWwQHqn9kYN4Swe2FiizpBWGWVKcP3vGDkjLPRPdHmTSJTnV5iVRWPGBZiIeXC0rbKsRDqzNk3VSCMoy7eIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtI3UR5x; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-57bd482dfd2so1458179e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 06:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762611659; x=1763216459; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IBNT01GDprpC+Qi0MaA9qnbmV4enoYxkVD224kY3WTQ=;
        b=jtI3UR5xgdFqDzD9lUnOr9kIl1vRTX9RQTzNQ2CQySMt+SESCZ5R13jx8T3wsK9YKr
         /3vs0/+MOnLTy3M0Vhbpv6fksVlJvIZ2hmME9xB5F0VVrhnn35onbZL6l0fq5x915+5t
         Gx3Dia8Dlz+mB6WEo9e127Ox72U86YjVfa4OzFikdi9fohF9IDOl1w3601rXm7PGUj9O
         eQEkKqsAol0tqnEzC6ZC6IQPOoS6dlSrueJDvwX/QT8wt2CNFBo6FRzv7ACYEj5jLm4R
         N/Uht4ETrwtRIwIwoGV/EhTHMAH5oGoi+m12XzDmNYqMn8e5frWyiJrWFaeuU8wu7ZUi
         5rvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762611659; x=1763216459;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IBNT01GDprpC+Qi0MaA9qnbmV4enoYxkVD224kY3WTQ=;
        b=SZ7oSRfsKFC942VkCMqEPca5VxdnJQoPy41hdaa4CsJpQJAE4kHMIssi1SZv/Z71TU
         4y3wEm8JPFpHmrj1Xx6FhFAnGNrPNp17Qvnuw2FZ+CjLgBMXff5TtqHyNgxJYPcGzTWk
         rqh7izRyHMVU5QeZ1O+hvYQzXIEOu4/R9rL+2F5EfiLTuwT4m2/k91EvfEI5Cf4F1iw9
         jZIfLcEfD03ccvNAkepWu7frF2HMvn1EhBlRgIwpBLa25foWU16vi77f65QURAajziyT
         mTGYkuNmgLTYhwtpgVP1CtoKCdR77f1jx5Pvi+CC4PY5yMChm+K/WRcZx+bdYJyGOACg
         mihQ==
X-Forwarded-Encrypted: i=1; AJvYcCVokx88DnBkNFPQTnD24GxiboMvdS07ZqJ2R2APRSJqfME6jbEiucMgTYimQZ/VdTdX2qpEwePFH4dcS34=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV4LmU3xCKnZGrOq4DWiwYtdaAgcHZu5+ncr7Hk4vQaQ0gXoIx
	UQNVsoAPm14Mf8p/NhOLnkMjvuxktbKKRHTdhZ/t+bE8AymH+TgUEJYb
X-Gm-Gg: ASbGncuu2LtYS0kFoJYuO9sd+zc1mpelz8Bv4+4p8mJ+DX9eCuxbitES350ZxBP51wu
	GtMr7tEbVFkxuCLbOS1ZDFe/DNgJaJOGTV89pJI0MxtgxtAIQUIPvG6h/8t43QnSh8xLuv88I8r
	ngFQjTfUb27MOJjsIiVAws3x3VrsEuldp6+E8Q5FN/avhT8nuRVzk/kxCqb0OLF29z06uy+b3MS
	tu1usY5YPbdkP/8S+FzSgHEtZPWjrmQroPsjwG34pHgjLwgp/9UcZURvx+xxPfV+MB3NemHrKS/
	MRB7LpokM5ZUHuYUMioJHYVPgH+uJxFFDf+qcCQGG1OpZHbyshM/rl8RFzaWPIVqBDuwUyePu7l
	ZdrlCvoL5n1UBfw382jOolJ+Us9CVXXQbqVmN9J6nLHE5pM3zSBYEvtMhsf+Lf6+cbWcWcWeZf4
	SyC2zlarCv58ozDS6y/Np8ct0Yf+uv9+CyH2k=
X-Google-Smtp-Source: AGHT+IGoGdgHNMOSPUHByNnptn2TL0lkoETjbMxJoanNwJoIHOZACq/hw0H4JSSe8EX3c/O5QzR0WA==
X-Received: by 2002:a05:6512:39ce:b0:594:2a0f:916f with SMTP id 2adb3069b0e04-5945f1db54bmr639319e87.43.1762611658855;
        Sat, 08 Nov 2025 06:20:58 -0800 (PST)
Received: from [192.168.1.89] (c-85-228-54-30.bbcust.telenor.se. [85.228.54.30])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a590d44sm2196799e87.91.2025.11.08.06.20.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Nov 2025 06:20:58 -0800 (PST)
Message-ID: <6b1743d4-cd9b-13ca-af00-f62c7f54cd82@outbound.gmail.com>
Date: Sat, 8 Nov 2025 15:20:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From: Eli Billauer <eli.billauer@gmail.com>
Subject: Re: [PATCH v2] char: xillybus: add WQ_UNBOUND to alloc_workqueue
 users
To: Marco Crivellari <marco.crivellari@suse.com>, linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20251107163755.356187-1-marco.crivellari@suse.com>
Content-Language: en-US
In-Reply-To: <20251107163755.356187-1-marco.crivellari@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

That's fine with me.

Thanks,
    Eli

Acked-by: Eli Billauer <eli.billauer@gmail.com>

