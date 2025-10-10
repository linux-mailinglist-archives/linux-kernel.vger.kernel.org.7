Return-Path: <linux-kernel+bounces-847800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A540CBCBC2A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 08:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8FB03C536A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 06:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4673423F439;
	Fri, 10 Oct 2025 06:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHYKV4do"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55050227E83
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 06:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760076843; cv=none; b=kqFBC5wqitC4wZqBEvURuKzoemgnZVDz5qY2lUkhLM8qxLrc1f70IONiwBpDc3gFrS04mrh6XrSMWPk7TcnS9zJ41X2dlDtf3B9QVzE/HywPyfYyS1CYXwGAEwNlOmpEGPIShTWQVQQCTh0zKP9l1ZASq4Qe1vpB59WKjR3zKEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760076843; c=relaxed/simple;
	bh=1v5NcS0vxoaVrNiPNGl8QcRfrGJ70C36+++6hlNjRMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gt3D3O9DIznNl8eeNxL9vF1MfH7uvYXHxmmPo5yqUTLQdd4oinxWEiYlC0GfUBYyxbf0Qt1nkjPtQcdX0fiy5wZwxLiaSQK0MWbnrLvVIo1/fUu40I7fz6NVmkeeclrU8tulnREp+ARfq+aGUS8MThbWDXagaM6/zFt24iB4LNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHYKV4do; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-267f0fe72a1so12313815ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 23:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760076840; x=1760681640; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZeZgHpNxoLpmShnYhfUU1prae6Lh9wrT/tWekhyimpo=;
        b=kHYKV4doabezjMieFY34F/w5R6MkrINaeIl35ZggTwRSU+mdNicvMd289A2GWv5wrd
         XkCrJ5HXu0dSopMjMEg87lX7TPcdLvt6gXHsLfoIehQINZs9H0IGVbvpDa6wzFWZ8Xv2
         LTfDi2dO2KROjucUN98okwsItFkxqCnVwQQi9i3MiDhWLsrP3kaEPTA2PbOVlI5bMhlL
         wNedJxESfrWrG/+bd0p22F9YZ4dmC4u/+2UuLqU9f5fFSGJvo+mnzz0/7VL7LgBUDQVQ
         GSsi8hx6LLdb1WZDJ59mpNwuUMWPXHwa8YsYqvr1Qgk81Zxce8+FKZFjqGY9yBRQsZa0
         851A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760076840; x=1760681640;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeZgHpNxoLpmShnYhfUU1prae6Lh9wrT/tWekhyimpo=;
        b=Aw2UuaSw+ywU+G/qnW+f+kOQ+YaQ4lLKXIOLQwuJMGFCACRHT1cT7/CkbsGozod27C
         8vvFjZ90GNBwNBA84UsZANTNL16soM2xuWxqaNQIWygXAvxgJkP2jeOLbuD4mGKBbQh6
         CewWosoG/3jeVsLmDjLZjRZUhGzg3Cl1vsoQ5BaHTLr3UNDy7VeM/cqVS51oWKBtwRr/
         VwrH0TR/+dR8HXnCXorOM5J5SmD6HzCkA+iqPNDypuHduD7T3oQYlpYNCQaXjXExAU1I
         /HktMvZeEZmgBP9kL3ow5R4eqN+llmokXqpqXVyTZy7XyJK7yYqq8uzCAHW5PKXFzKji
         6dQA==
X-Forwarded-Encrypted: i=1; AJvYcCXEOk/p9+Wm1XlaMKnW9ZP1ntFKfNlROGZhlOsiOMN4SEtukE1g+PAu983E/DWFIR8MmPH8Ew7nkBw08f8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw370l8bshJzh0B8YK3OqyzzmRa1i1uuMs/jRnA3bd97HtCzqvG
	qmf8lXdrOK1Z3XEEKPz5BVB0rZM69hLaMKtKHDtHVtKtGU+Nfp85Mbr1
X-Gm-Gg: ASbGncv2XMNtVA8Opc32Qm7Tm88KKEXre+wGo1+Lgrk89KbJW0qdwJATE7LaLqvRHjj
	B8Ye2TxVKvunytCi/0w6+oDjWpF7eQDtVyIOgW8cBC31/ZOeyENptFwPPnoAJvR/gADyQ1gzUH6
	nJfSz4X8QQMURY/QoBA2l1f62VWBnimE9I3GUkn7UdjFOxhaP3D/6Jtw4N/XzSG9838QrjsJZ/4
	Q6J9WBlSfW6ofvEwhu4Rj6z6CLLdFbvcQrOqag3lCvdRjF0lVeDa/zZVytxR+RcrXbWG4+p6Dfv
	KPeiBzzpv/00ccQh1nKBXeOnvIGtdKicRkv/AV2tozgAbey5GD/JTDyRjKrS4Y7p+jZDS/UL/4t
	YZSVDUV/1CxhgVOvxhZQa+Y3WYv/G5qmuTARAndvuwhrTuodNrJRA3NHDWPYPoN695gEpENUrcV
	ZBcW98
X-Google-Smtp-Source: AGHT+IGhZo9EHJGeyJ7Hv8uoiFml8F5FMqKr/vrLQTWePNVXfivw4o/tTOUhOD4QMWgfGle0YhWxww==
X-Received: by 2002:a17:902:f785:b0:27d:69cc:9a6 with SMTP id d9443c01a7336-290273959b8mr122074805ad.53.1760076840512;
        Thu, 09 Oct 2025 23:14:00 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:c593:2dc:16de:acd1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f070ecsm46772125ad.60.2025.10.09.23.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 23:13:59 -0700 (PDT)
Date: Thu, 9 Oct 2025 23:13:57 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: =?utf-8?B?5Y2i5Zu95a6P?= <luguohong@xiaomi.com>
Cc: =?utf-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>, 
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"jikos@kernel.org" <jikos@kernel.org>, "bentiss@kernel.org" <bentiss@kernel.org>, 
	=?utf-8?B?5p2O6bmP?= <lipeng43@xiaomi.com>, Fei1 Jiang =?utf-8?B?6JKL6aOe?= <jiangfei1@xiaomi.com>, 
	=?utf-8?B?5a6L5a+G5a+G?= <songmimi@xiaomi.com>
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI06IFtFeHRlcm5hbCBNYWlsXVJlOiBU?=
 =?utf-8?Q?he_zero_power_level_of_the_HID_device_in_kerne?= =?utf-8?Q?l?=
 6.12 is not reported from the kernel to the upper layer.
Message-ID: <lel67fl7rgv7j6eyaf2xbblcwijuuqqoqs77ahbfmdu7ra5bei@zjvzeuyckjlb>
References: <d2cada7efe8d4436b6e638fa1e0aaefb@xiaomi.com>
 <aM0XBudxlXuzALbg@fedora>
 <px5t2iedrrqhcrpdvmu5pznp53d3e5jp55dm72phlsti2rmt4j@rj2pajkavuir>
 <91e0d952fd774e769e2d24ce2165df18@xiaomi.com>
 <vkm32giijggtzv7hudsvqg34utpqvw4nnccfi7d4txj5tlzstp@4bu2ox2lmtm5>
 <aada0917f31641c19ba7c48e3c6d3c53@xiaomi.com>
 <39809571f1b7439abd754279fac7e702@xiaomi.com>
 <80a4f9e6416944d3919c63a392325d3b@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <80a4f9e6416944d3919c63a392325d3b@xiaomi.com>

Hi,

On Fri, Oct 10, 2025 at 02:25:55AM +0000, 卢国宏 wrote:
> Hi Dmitry,
> Please let us know whether you plan to merge this solution into the kernel or not! Thanks!

I just sent the patch to HID maintainers. You were CCed on it.

Thanks.

-- 
Dmitry

