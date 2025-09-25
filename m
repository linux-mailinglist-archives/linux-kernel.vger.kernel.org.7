Return-Path: <linux-kernel+bounces-833177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95509BA15AF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 550B03B811B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8007245028;
	Thu, 25 Sep 2025 20:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6nVajbX"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B949DEAE7
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 20:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758832250; cv=none; b=RjHXGmCPvk/f4JW23imFTTT1MByywcx8RPV5OdrcxanS+8ChJ/Ur5luzLjhDFwc04a1B4KjH7kjtLy5N7uymNmF+MOal19VJyka+my48zd7vD9fAKNZ5FDCl7OnwPKLVZrel009ziVrLKb01beSUk5ZNV4nYcM722tobh2l422g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758832250; c=relaxed/simple;
	bh=zdQFlyFtcJGHLR3n1F7B85z1BwCtD76Pv4Q5/J3RMhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q3abQM5/RMOCgv9OKsI36v5e8VcOfa3g8b8NQVSKSwTw4KkplKFcOf1XCRB5ripJKBL5nM0bEmSSSSgU9+Fbi7JARgbXEuQ85H4m2TuxKTFIRHinblmqQiNzEzE1Mqgcy1RLQrNEfXk+WhkaHNLNNqwc4pX3HAwfeGFF+lZZjZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6nVajbX; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-41174604d88so541752f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758832247; x=1759437047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCkZb6qonleX8R/f+hgTPmeir/ympFYBeTfUCEgU1Tk=;
        b=a6nVajbXsGmlDzKE5k1renbrqYKX68uyYe8nL27kFsS1ei/OSGJUv2sc8RDVNjaBd1
         b+z2wNpRDc04m1yVQvKl2Exv8H1SH9AA4RIR6E8mkXevB8K/S2kWD6v1JA8zZLoRz8Uh
         kYziym6ulH3s2HY1f6ywrVbTuz32e7aPmEplwGEpbCS0Y8+mkexQiDMw1Lzf08DpeMO/
         d9Hw/uu908GB1s9u2AwfZ25LGWN87edMrzAwOpE60zCckBZkMs7jLObc8R35OnAMthMS
         Pl2JXub/7FM3qZ0y7MhPeFG7vTGL4xNzQdMWQW5lqRXpVAXoni6xTEdUjjnlB2yMu/3C
         Gpuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758832247; x=1759437047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RCkZb6qonleX8R/f+hgTPmeir/ympFYBeTfUCEgU1Tk=;
        b=VjNX3L1MpvhIZr5eYYQo8flIoEPyRePErw+2FK8P70GFMeiiP9UCeeaVurw5tkSzue
         9N0uMFRSBAmnqjzlfkzje96ZbNcviuBrjDobTwFKpM3j7BzCgp178PNJmzEa5JoSJACI
         DN3pabgKa5/H3FFQhG45lvgZtorQ6q/OR8t1QC17aVpgxSIeX1vSFiSPVyyPRJf0DtRm
         dzVW++dkW5QSvF+3//jKgVItILWl1zuENacFyTG/3taWq4o/UPm9WlKChKuOf6AtvjyR
         HEALLQ9pEdEVVxVhuwBt2EFV/fOIAw7rJzQ9ku0/2dIwemEIecde8UkGYcdCQL2FsMBz
         WRYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAoRffI6LBGL8KQwLBTzsnWMws7KoPsMkwCo2wFjxEoUUweckYdKHrOSNJJToRzXGNiVJJbOrONMC0mwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcWpLFi6QoelKFIopvwFg3VyCIMqRPVQwNe1aueepITAlJBEtt
	NH+v84o3ddvWdi5D6U86nE7fB05a7FyeZto0TEIJKe9AGUkM3JMo4gJa
X-Gm-Gg: ASbGncu4hq3Z8k7TwADlAuOYvNlMkrWy/VTdGIyzraiFwb7bUzov/tAYUZiJwujD+dq
	HrlZH/EJJet6CdBomqSRLlKjaAeLpUZYgo7SA4qzeCv9jm3n062PMZXFcsePYbcfJj4VXZ377zL
	lejPVxVnLcMFH0kAuaJL0XK1U2x8x7beM/egzq6obywt0F/pMumpEhAP/gJ0kXMaKptQzh3toPx
	wDIcgrk+pJLhmxmFSZfVQtbPIwoaieeqJyUyPxRzdCOvOGir0QHJUKGZL3+zan3pjBqksSa2kCE
	JE9s66C0HlJ7b8i5JPDdC8NLQW71UE/eZWuB0UXyH/ovTCAdxeK+7lNmiemwn4Y9h+elsoakHQT
	9rnX0DMi2k8gmUHK4sDXXaQ23/CLHhxLn4QT8JBcE
X-Google-Smtp-Source: AGHT+IF7tg4RCzm9amlg/Gw/9ESY2ELu0mfn9+u3GRg5rzK8YPUdHN3cvSLydE0mJdxjQiAumcfhYA==
X-Received: by 2002:a05:6000:25c3:b0:3ec:6259:5096 with SMTP id ffacd0b85a97d-40e45b8770fmr4070695f8f.21.1758832246817;
        Thu, 25 Sep 2025 13:30:46 -0700 (PDT)
Received: from radijator.localnet ([93.140.105.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc82f2ff6sm4137336f8f.56.2025.09.25.13.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 13:30:46 -0700 (PDT)
From: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <dujemihanovic32@gmail.com>
To: soc@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>
Cc: Karel Balej <balejk@matfyz.cz>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] PXA1908 DT changes for 6.18
Date: Thu, 25 Sep 2025 22:30:44 +0200
Message-ID: <2398680.ElGaqSPkdT@radijator>
In-Reply-To: <c0516d21-16c4-4101-9d9f-a679f7459ef5@app.fastmail.com>
References:
 <4685744.LvFx2qVVIh@radijator>
 <c0516d21-16c4-4101-9d9f-a679f7459ef5@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi Arnd,

On Wednesday, 24 September 2025 23:41:17 Central European Summer Time Arnd 
Bergmann wrote:
> If you can send an updated pull request based on -rc1, I'll
> try to do find the time to merge that, otherwise please
> rebase on 6.18-rc1 once that is out.

I don't want to rush anything, I'd rather wait until after the v6.18 merge 
window then unless the merge itself is very trivial.

My only question then would be whether I could still target v6.18 or would 
that postpone the series for v6.19? I don't really mind the latter, I'd just 
like to know.

Regards,
--
Duje



