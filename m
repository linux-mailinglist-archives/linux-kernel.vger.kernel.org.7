Return-Path: <linux-kernel+bounces-735175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7FEB08BC8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351AB1891C9B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52C729ACCC;
	Thu, 17 Jul 2025 11:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MStfA7yq"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408A5275855
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 11:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752751927; cv=none; b=EyPPyiULQwh4lARfKvuBJpclzNoIuIkTzUYjw3bt8kBvnwwa34/Y5rdBoNaTJ1uU7b4TKzKDCgWaH8lYgdfICKJ3ykve2iKtAxj1efAHD/cbyONJ1j252eNGHojVjuf4EhRGuikSDKxD5t3lji28k9f55j3aLKGlELuNR0UxWu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752751927; c=relaxed/simple;
	bh=NnqdSjL+Rs0PFPzmqEJ8dyDUymEj23QKvWFQ0LII9cE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ghg3sqKV4SuZX34lvVG+pWzE2FPMOahjwEphIREs8Y/+liZun8SZoxW6TEvCNF2dyKEU0dc2jIRuY0tmWTg5NJmbOqQuonFQ7vN9l7eiGL9L/DeItXrTPX3xUPo1WoTol/5jvdifUIaSl/ClyE4pNmeX9+4nl0M+bIpP8cS8BYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MStfA7yq; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-607434e1821so1229186a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 04:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752751923; x=1753356723; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1nbfA/BUePz5jg5ZXDN13NPJjAM7aHo+l8+nJUpAVbk=;
        b=MStfA7yqjyUiy6FWorOWCGMnWviIL61MbYLr9+S9d2cEU42jgE+c+ZTMbOdh65TyVK
         Lc2NRilJf3B/KlkaN9eZoKtq+AKdH/gei6xAICwkqWaqcE5+1eSnU85ITN4rNfw2qt3F
         Cg80tcjDVhQS+k3XPQGpRpPYseaYHuvmIG77VAUUqKZS8oYa/1QQmQcruoths6xaWwO/
         ArzBSosIfztsxjVaIanBegJRKz7GcqwE5FuGEqQ1k2+M07PURDnAh6kZhiFr7msDjTHp
         cJSxtayH7fYwi3krzmYDI2Skl5+0yJj1sFWfKJCHWcZCjFThZA/+U2Q51z1BhMxBuVzP
         T1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752751923; x=1753356723;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1nbfA/BUePz5jg5ZXDN13NPJjAM7aHo+l8+nJUpAVbk=;
        b=BhpoSq2+4MblbPnLP3ASqxCrNkG0vjGRUgm2GEU0KGfeVrFulI5YypWjJxe/bIJKzF
         xkiMIvrxeXv21X//Jc7DZAN52+bKA8SpUp7JRr7lhn1BHqTPpgQCWVxonFqTDmRLEeqB
         mjMwFLdPc1iRhGhuu0EFN8fLtUFzKOGvDRpArslWraaZVjbx5F2+j5Pq8fBcuxrmyfl1
         eQQAIjvgJyaJqdk0qypFd+V2gSaczPtoXutMbDnQNcx5AgbNaHk+J6pS9271nGQY4kGt
         szE6C+XvrGtlpsQRB/AZkG2IBCx3gB92m5hO250rkmv1yi7a85ID6yuKmIrrU2xHxBEc
         41Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWWqy3ZHjR+DKRgBEGTckzaBJ8+QpZriuMGmwElFiiMzf9BVOGK7Ja+LI5IGGdQ+F5dWxjn+tAAHEtZ+jA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUhcyvhTkR34Y3pOocd4vIlelzyXkr5R31JaLYoz/v/Ebm4wNe
	t8SSkI5OiMygkFI0SivgTJcBhdKB47vwNS7bRbNq9Bl5NCbN2+hSI2T2wN0Z1bEUpH4=
X-Gm-Gg: ASbGncttjUfnzjEF9Nbxkx0yLPrVetr1uTtJQDBy1YrFth3o4UMkvgOG1bwUuCV9Ln6
	Zfqd6RoZYYKJR21H1bhVG11WmkuCmkaarXpqf7ZURYczXpa0/RRsO8rAv8LsRZG6Bt36JymduFl
	ItYb4sxNbL0Rx22unES28x2wSAXb1zQXEPPAHS4zMqljOLgSgAlyXOVSFm46iYDCcU0lYzyz/+0
	LGfBWkcXFq7DNNj6WdZKTVtOk7s2DdixSxw6QKgofZ/XmX4UazhNoU22JFS3BfvLLh66HGmf74i
	iulZT+5soN8lcVrQWfguhXYkDt0jtwuxTiUW4jLe1D9xxgyIE5zEkXJOr3KsKYe/zFIP6ApUbS4
	rEj4TRgI176czlpy/r8aJhFjNPBzKgFixaLQ6hr6VvCfaa4uKechQ4WBfH1+cVpIlSQ==
X-Google-Smtp-Source: AGHT+IHPpC07daK6TZIz+cLHthKtlpaXonfdOizJqTxBI8T6DYPMH3DS44MzKOLbMzR4Y0XLAVj+sg==
X-Received: by 2002:a17:907:e2cb:b0:ae0:7db8:4189 with SMTP id a640c23a62f3a-ae9cde02ca4mr620673166b.18.1752751923449;
        Thu, 17 Jul 2025 04:32:03 -0700 (PDT)
Received: from ?IPV6:2001:a61:1347:1201:4432:54ab:26c1:9ebc? ([2001:a61:1347:1201:4432:54ab:26c1:9ebc])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7ee26b4sm1337874566b.45.2025.07.17.04.32.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 04:32:02 -0700 (PDT)
Message-ID: <f63f2b91-a217-41fb-bbbb-1810d98838fd@suse.com>
Date: Thu, 17 Jul 2025 13:32:01 +0200
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
 <fa20ab91-5ebf-427d-b938-31ea6fb945cf@suse.com>
 <83B89F79-D28B-4F2C-87EA-F5078BD7ED17@zytor.com>
 <2c807a7e-d55d-4670-9a86-e3fcaa3e52ba@suse.com>
 <927f2d40-1004-4738-a1bc-0000d4d3e179@zytor.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <927f2d40-1004-4738-a1bc-0000d4d3e179@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.07.25 19:30, H. Peter Anvin wrote:
  
> ERRORS
> 
>      The tcsendbreak() function shall fail if:
> 
>      [EBADF]
>          The fildes argument is not a valid file descriptor.
>      [EIO]
>          The process group of the writing process is orphaned, the
> calling thread is not blocking SIGTTOU, and the process is not ignoring
> SIGTTOU.
>      [ENOTTY]
>          The file associated with fildes is not a terminal.

I would take this as meaning that we cannot just return -EBUSY or -EWOULDBLOCK.
Hence the generic layer would need to implement some sort of waiting
logic.

> That's why I said if that is what is needed, it really belongs in the
> tty core.  That's where the current internal delay is, after all.

Good. Don't get me wrong. I'd love to do this more efficiently,
but the current API is less than optimal.

	Regards
		Oliver


