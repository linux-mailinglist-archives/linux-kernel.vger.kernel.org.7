Return-Path: <linux-kernel+bounces-733130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (unknown [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 559E5B07091
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EF9C58295F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11892EBDD6;
	Wed, 16 Jul 2025 08:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TJ+DqaZf"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453DB2EBBBE
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752654572; cv=none; b=KXip9M+CluqCamwKXvLv/dSbFvYSGwUncQG+VRQ7fbnaeRhKY+pttOeblyNyYwpC+3ykWc3aq14HS1C13+PFKo3nMgWDS+Cp5S5KSFqVrSk5EadrJxi0OzYZgb362hL8KS1F1ScjKBucSIJ+xPSf6Thlb5XwVAeUkc5pZfCoL8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752654572; c=relaxed/simple;
	bh=/dVOnKYB8CD/wyyHbMWcCAYLrsRBtnjmn40w6cFnUfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZaPWa6x9LhpD+W9jSUKyYugxIpxs9y7qcIkNCNvtXxi5MFOuMtABToDQZF95btdyJpwmQ4DR2097OeiI4jb0JkRtJxHbG9w/dgqHY5wU4NspFUYtIEqmuDV4inbNNyts7Mw11ivArYKM9bz8pyGcz/aZC5zrpbiqLIbLAytqris=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TJ+DqaZf; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a575a988f9so3671397f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 01:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752654568; x=1753259368; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kTS987hZr2/BPWLmY8oveEZ2X67lASpu1Bb54ts50jo=;
        b=TJ+DqaZfl0zIkqswkSGb6b5pGV9HjXtR9W602M0rVQSG5DF65rjluDPe+4ILj9b0xD
         dQdGk+32aL1h6rxwo/lmrOc4pUZ/8LUMZ9u/noYWD8KZMRM/qJS6PorYHnu35IVMgeyS
         9tmAiw9zyY+Y4or08t2QxQm3vpQiZKYyy4yfMlJ8QqYvxbXa1q5KVodNevEzG0lpvLWf
         zVyAR/H006nurUAGEEZx0AmFMCLmEPeXsYjPfhOW9OASpo3W5S1WX5WSgE1/ZhwYWtlo
         EDtoSWGFOyIDh2xOD0LCgtbPQhm3fDnEMIg9faXtbQICCpUH3uJflijVdayK9HDzQGbj
         ZyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752654568; x=1753259368;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kTS987hZr2/BPWLmY8oveEZ2X67lASpu1Bb54ts50jo=;
        b=rJIQLzslG30iV+cz7xQxK+N2UBr1bL00WsRlhTXKQCZ/Z1ROvgETLcLaN/vX+TEzhm
         5t2KN276oUlYVzvsT/02Cki96fDoS95MojnsRgzHts8qRvR2rXk137DmLKdaKjuW7jsP
         hJaSw8ntu1MyU3Xcc6BW9Syp+/Lg0rp5qZ1xcYqMTuF4rZiDvQ4K/0fKhSfBd3E688NK
         W4Tjv5CqDLvRyd/s7mvR/9qYmelJLcI9oOTV98+p3qPb0I/H6K8v9v12W0i7v66X+LNQ
         kXA+Y2ASmo8/9+0KNz+HzIkTPoAsnCLdjx7PMoykm/dhjXlDkL7Xd43xLCGDviTHBB2o
         tC8A==
X-Forwarded-Encrypted: i=1; AJvYcCX8slzTtM+urC9tri95TyQX4yIQJ2gRCGfYitaBK7aUZIRzmdNbRk1tDyAv+QunKWONyhpzg0n0dgqHgG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGSl0AB8MaIFOjU8V0fAe++jFyucRm92Wah2qsIigNtqOBXvqD
	w1CtIKlWX2l/QvqTIhik8RJkus7y+fu6SEsIkwqXEvXYe0w7sSVzoJG9SzkPFk0x23c=
X-Gm-Gg: ASbGncscZY5Q82B/QuEK3+2bRNdzhcRk8dGgdEfESi8GaXDUYfKZqCKJChAaW9BIERT
	e68fxzKRb2s/GFRzY75mGFtulyqBLGNHVQgK7vxZ8nK4/zSsjNRTR2vVNIIkBMFN171QXQvrdUu
	RaQuQ6bId5xiGiRMtlFA96kEYIaPrvCJG1ijswvkmrKgbHOtueCZIDTwwt3QTn1tyan26Qu/nd5
	u0qnuywuA4aRFvNI4IdeuD6YVOUsjDQk6HF5WScxmGxkYUAWXV0dR0kFTZOMNASC6iPSxFXD7ne
	q8NDa07g9tD9HkFgwyzi65efpzYTiJ1M/ivJpjhXVW7k9acTjlTvNfzTmKdaXgFRD1Yy91rc6GY
	DV4IXHtdw8X94XGa0XHyGca4bJQ99IE2wHNXFmn0V6051rJbHLdhEILvKuMqr9LhF6g==
X-Google-Smtp-Source: AGHT+IFSZH4omeTXZAl7Lh2gjNFC0tMnhjbsZXaH62GbzEcddv2hbbklP4Avf1fLgsmVBRMpxR52/g==
X-Received: by 2002:adf:9ccb:0:b0:3a5:39d7:3f17 with SMTP id ffacd0b85a97d-3b60dd898c7mr1162606f8f.47.1752654568473;
        Wed, 16 Jul 2025 01:29:28 -0700 (PDT)
Received: from ?IPV6:2001:a61:133f:9e01:b1a5:79c8:d196:e761? ([2001:a61:133f:9e01:b1a5:79c8:d196:e761])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e1e332sm17275063f8f.79.2025.07.16.01.29.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 01:29:28 -0700 (PDT)
Message-ID: <fa20ab91-5ebf-427d-b938-31ea6fb945cf@suse.com>
Date: Wed, 16 Jul 2025 10:29:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: USB cdc-acm driver: break and command
To: "H. Peter Anvin" <hpa@zytor.com>, Oliver Neukum <oneukum@suse.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org, Jiri Slaby <jirislaby@kernel.org>,
 linux-serial@vger.kernel.org
References: <ce54ae11-72bb-4ac7-980b-c1cbc798a209@zytor.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <ce54ae11-72bb-4ac7-980b-c1cbc798a209@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15.07.25 23:00, H. Peter Anvin wrote:
> Hi,
> 
> I noticed looking at the CDC-ACM driver that it uses the assert/local delay/deassert method of sending BREAK.  Given that the CDC model has a delay specifier in the command packet, is there any reason not to set TTY_DRIVER_HARDWARE_BREAK and sending only one packet?

1. The existing code is tested and usually works.
2. The locking goes away. I have no idea what happens if you are
sending a second break while a break is still going on.

> I'm also wondering if it would make sense to support the SEND_ENCAPSULATED_COMMAND and GET_ENCAPSULATED_RESPONSE commands, presumably via an ioctl().  I'm not 100% sure because I'm not sure there aren't potential security issues.

Well, one of the purposes of the CDC-ACM driver is to hide that
you are talking to a USB device.
In theory we could do that. I don't quite see the value.
Sending arbitrary data from user space to a control endpoint
does not make me happy.

	HTH
		Oliver
  

