Return-Path: <linux-kernel+bounces-784440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDDFB33BB7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 407043A37A2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EE92C21F7;
	Mon, 25 Aug 2025 09:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ELnT3n4W"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A332D0627
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756115415; cv=none; b=ISdWsBsw1U1OSYRLZtsLniUKsa8lHOWAQv56yDE4t6dRI/1BTMIuEJBIsuP94U86noJWRWfv4WrqmkSHLhsNdsQwsxxwzpeRuXR8lP5EutubZYR7O43P84wxtSqKV/Xu7dsU2i6boB3v2OVdREMQhID7J2GpKvHgUjV95EoJB0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756115415; c=relaxed/simple;
	bh=rSPLVwVRYtoEX3tE394IBz28Fa6At/geG9f9uhQEfGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p3YMuUHIF578WmWKSRtLvwsnY97w+EjxtUkEoz/3osxWqLwOFNZNmXCc+DS3NcB3R6+cAopSNuE1fpSzII7IbltVpoVLpDZImdlErLvioyorqsMiH7+acCrtaX9m/SRIor8HXYLNOBw87jnYbpdlNAK8NGAmUxrmO0tGmG4vC7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ELnT3n4W; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3c7edd71bbfso1628649f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 02:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756115411; x=1756720211; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qLFcwxK6aQsMYN2cUvNdkLnGkPTkP4FcbXf+axT32gs=;
        b=ELnT3n4WmmL8Asqw+godCgRK3SZ+1EYHKcmT/szp/63YdG35Yoid1jnvkityhxsbX3
         rdO5Jn1+7UiH2LtLMjIlb1XfObsvzP04TWx93kLpB4+ln3Y0zM5nWjHduEHfQApCmu0f
         HBlVsHUQ7o6pSriYDYPLwxL+ARi/OijjmB+3rGq6SPhuIyBcGu4HlhCkg5/PsU1vq0j0
         skMvUz+dRfLMlxiT+HmoQQhgtIK3nR8wrbWYjPSP2IyogZq0CprXM6vi8tiLy0EFp1rd
         BqjMVfo6J0C5cNnadT58JTNzGZHutjO349nk0To+f9I3up5D6gf3bad/3yUlLYZUFJyu
         7JUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756115411; x=1756720211;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qLFcwxK6aQsMYN2cUvNdkLnGkPTkP4FcbXf+axT32gs=;
        b=O7VhChuo3+zI55MpabefcL9eSuwQIaudRTHfLM5w9VYRTEIa7FRfcDpxi7f6GrWPsd
         +4VxzIoPNscjGa9jvIMxHRFZYjFz5YziaI0rS+J5TkgiY/aJ3Dt+kngbVBC+xvI9YlTf
         lsS7311n7vS1q+v4PTFOnX8/QsyiJ5RO//jL0idpHsM31eKNYRZG2kS3WMMKj2khrite
         gNGo/gAnPmeGsFwZ19IB6UerAIL02GcY6Nzm+G3aBbjAG1TYtd8Q4JVzQJdyv+vG4UnC
         q9YZYjb/M8w0f3+WpR+3iCUSgNBMJX2ngvj0t299AzvlIy8rPt39VZQ90/uwHdd+V5kP
         /2GA==
X-Forwarded-Encrypted: i=1; AJvYcCVFgmNMVYWk095f6g3Ql4y0bA3W1KLRaNSn10GLfgyOZVQkM3e4gYt2Hv2mCYrHQTcbkDA4gTAjiFKnEUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNn8D7kLSAW2s+SgdVAI/9IcchWxrxQ6qdUmbTa7rDkPPokEar
	0sPcWkIusC64PvDxS3gZhR+PCoQP40rNiM7K+fgO+pJp3y3X66TZ7gyLm0MpIGzXM7+DfZCam04
	B1Gbq
X-Gm-Gg: ASbGnctGc/CchSG1ZvyaasZAaON04VD7Y/iWQVkKmf3pI/IsScg50Aa1JH0lAUBm+t9
	5tsVUOIkKsSXtRanmkEJJ3/l7+tx53k5XAema866AHmcQPEB+WfDkBgaCIibad19/8XhlXR84PN
	S+VAPymrvUFsMtXkdCVuCIM4aVim2SB/7xcR/L8NAcmiQY8j4ZipkdiTSsCga2Abu3uUOGfVjaT
	Nsdal/GTAKePPk2gccsvhEQ8zy0TaE2P7inCeoK6E1zCnexL9Q1/uiSCuW1m2FUMKrdh5C8Fdbz
	nt2C5nEetX2/2aMgonHLaCud4UFzT3DuQVUjkBERgE4O6JuDCiJnknQ0YL/N1EddHQxY0/HHmKY
	ypYwKtrgWBx26xKSFvO+XMcS4SaP5Im9EVZrqsM8GaWhFr4BCd4WtKO9vmNMZtybCaA==
X-Google-Smtp-Source: AGHT+IHlxZp4SUR36fEEfULy2tEt0dEYaJ3MZR49/fCkVKT3p8d/IQhSLfHWvxm3MBd0y6+YlTgYKw==
X-Received: by 2002:a05:6000:2907:b0:3c8:a4f6:c8e4 with SMTP id ffacd0b85a97d-3c8a4f6cb41mr2738295f8f.52.1756115411215;
        Mon, 25 Aug 2025 02:50:11 -0700 (PDT)
Received: from ?IPV6:2001:a61:1382:1301:13e6:2b3f:f0bc:1e1c? ([2001:a61:1382:1301:13e6:2b3f:f0bc:1e1c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ca6240b4e1sm1088151f8f.21.2025.08.25.02.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 02:50:10 -0700 (PDT)
Message-ID: <d3ee7c98-c987-48db-b68c-645b38ae51a2@suse.com>
Date: Mon, 25 Aug 2025 11:50:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: usbfs: Add reset_resume callback to usbfs.
To: =?UTF-8?B?6Ieq5bex?= <ccc194101@163.com>,
 Alan Stern <stern@rowland.harvard.edu>
Cc: gregkh@linuxfoundation.org, jannh@google.com, rex.nie@jaguarmicro.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 chenchangcheng <chenchangcheng@kylinos.cn>
References: <20250822024602.42894-1-ccc194101@163.com>
 <f159e37f-3b27-4977-9712-345e8902eb48@rowland.harvard.edu>
 <4cdaecd1.131d.198dedeefe2.Coremail.ccc194101@163.com>
 <379c80f7-aa01-4575-aa0b-d64ef01c1346@rowland.harvard.edu>
 <23f1c6c2.2011.198df066c15.Coremail.ccc194101@163.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <23f1c6c2.2011.198df066c15.Coremail.ccc194101@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/25/25 04:19, 自己 wrote:

> According to the current experimental findings, when userspace encounters
> an error while using the previous file descriptor (fd), it does not proceed to unbind
> and rebind automatically. Therefore, the two uevents were added in the kernel to explicitly
> notify userspace to unbind and rebind.

Sure, but that means that user space has a bug.
That race is present in every case. Even if the kernel
were to notify user space by additional channels,
user space could already be in the process of calling
into the kernel.
There is no way of avoiding the need for user space
to handle this error return correctly.

	Regards
		Oliver


