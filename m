Return-Path: <linux-kernel+bounces-786167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66653B355E4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86CB824682B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570712F83B4;
	Tue, 26 Aug 2025 07:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4n3WJuX"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5214B26A1D9;
	Tue, 26 Aug 2025 07:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756194018; cv=none; b=PufzZeHoyN33SWdcqfrxUT3j0E5gWnd8pyNhlxX+uV/m6SViT2mOuU4Wv7MHMeVcJbrzOK4qSSMPyhzw5wbMrhsexfVec/tNy32AQELX7lDOPanU0VBYrOWkoWBsg0IEGTS8lihxuvjQjxabyyz64ITQ/41caHEZ44DiJFN05Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756194018; c=relaxed/simple;
	bh=aap3YfstIpmOugt7N1EyGswpZy2EVkO50+yKxH3lXd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SZKbuzgoRLcKZr0Mf0hwGHPeSOhjl/CvW076yloEagRjTq4awyTfsR9JyaldoeUyg9k+2TW47AHGX8aoWu2tk+bWCugzdHF6jOSxQCbZEsW9QnI5VA9leQ2HWrAXQuog4ikKQQwl3rlltdGgoqnypYczB6P6K8bKC3nMM5yyZdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4n3WJuX; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-770522b34d1so1931674b3a.1;
        Tue, 26 Aug 2025 00:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756194015; x=1756798815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GlbFv4vmVbgsFd2sczt+i99ediLghxVAk7SqSIFFbE4=;
        b=e4n3WJuX/Q6YgTLn7k4IohWLdhknEao1W3LGwfRFYTMJmC8pu6AQp3jeKOPnWxqsZN
         RFoscx5bo/QWzVNpO6XUSWVHx5ZNb6RnTsVGrGWyjZirNNfhbLyYrsPP76y0WXWwouNC
         TD45scSfDxuHMOZAf/0Yx7J0fTi452spzfQzTirra4P1YlgixJq60+lZpMqCdOFlAP88
         yt5rFJVWl/ANLb7o+tgpL6pczlw7SWCqPEZtcB8XSMegW74Tod5mwDO8VNChtp64XiVQ
         hI+g5B9nWizqFEtg0zFQYBBo5jYYAPniFRMmY2eFkCtGcdaiKwGMZ0uUcyFMkk6P6Yr1
         Ovtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756194015; x=1756798815;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GlbFv4vmVbgsFd2sczt+i99ediLghxVAk7SqSIFFbE4=;
        b=l59oQeSLxsz5tRJy0Sys/OK9OBa0SXDmvt/l1GNtU06LwOR/2hokvWl0mkILDSGz1d
         BkKoH0A1PLMQKkQjECdDqGU18dhuVVyPynDe6qSOWTAk9u+Euv+ezgwNDUAXMbmDP+KU
         1CY37iRPPBJDgSOG30V5Sy5CvZes8sf2RYtvY3K8D+Th6tUiZgcu1FTjj6xaMqkKjA/R
         fCGTuU7byyjW5wxH6B+0DumWwop/npAhTuzZbJ/amjaBmRIpcBrh9eTL7kzeOAndH3xZ
         JJU67dnLooza/2sEQbitvvTF0Cbsh+4+OfQ4AuqPZ5/eR6vqB9KqVumZHBlMEPJdfy8W
         L+dw==
X-Forwarded-Encrypted: i=1; AJvYcCVwncOZEy4O+GSWnxourHUtRoao8xHtU0ahYuK9SMkb381l+yzvbKE6FCeZL5Iy0/qWe+lWkfDaM2hb@vger.kernel.org, AJvYcCWHd0DsAzk2ortyVmmICnZztK7OVVuVWl2NQ9Vu4wd81bqxAmFa82OUDyNTx8j8iu0GawX7zgrrhHM=@vger.kernel.org, AJvYcCXD4qTugTfvad5Z08QR40VvFcj8oL6fPE1Jzut6+/ES8dfo/Hcooj681y1JoNcUGW8QPNQiDlx983QcxL0X@vger.kernel.org
X-Gm-Message-State: AOJu0YzpvqAb9tfmcUFCvOZK5BMZsA5Go1NkKJ7QRITirKfflYDwXiGy
	so8SPi4NCblf6gmePkK5lmK7fQMj2m6Cv7iwk7zXdkbGHrYHyWWru7E735lYbXoO
X-Gm-Gg: ASbGncvxj3+cuo3HilGj/HQnbE2L5+qYQb+iih4MdjqfiKuG9VcKilBvsNXUAuu6qWW
	BMrHFqoEOvc9FPMBYBaiaRfo/BDWmX7k6Q6ehV80eKhnMYlTHUEOvUqdf9ATzehSGG/7N7JJO2C
	Uf2lLgccgYi+/3gxEU5YM+hER3NNVz9tI+bONSNPc3AQ+J4wdIohC9rnzrTAQbTPMkBFWL1sk+C
	CXyGXWKAsBmEqPOkDG34a0wInoaFh9k0B5OcJlz6zBBXDj/kSEMgeMwWKxdoWTNgxOT1+F5OXlu
	EHeybTKK0EjYpRcPxNrWlP1WcPON8UUq7OghNWUVhoQ0TOecT7aXz5Ja6CULre2FUPagqkOsnVK
	wezY0CpnudPOERa4lvE6d29WIqei2PmJ2Ov5qwqaq
X-Google-Smtp-Source: AGHT+IEo7DE5YonKiPjmaH7yUDozIn0df3VhZkF0e6/hdlJHZzdd2jbr7Cod1Icio34q/kEknSwLeQ==
X-Received: by 2002:a05:6a20:7350:b0:243:4aca:f6d5 with SMTP id adf61e73a8af0-2438fad27f1mr690158637.31.1756194015355;
        Tue, 26 Aug 2025 00:40:15 -0700 (PDT)
Received: from [192.168.0.150] ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771ead8f278sm3681715b3a.14.2025.08.26.00.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 00:40:14 -0700 (PDT)
Message-ID: <2a66319f-63f1-408b-8815-89254d68b90b@gmail.com>
Date: Tue, 26 Aug 2025 14:40:08 +0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: management-style: Correct "know" past
 participle
To: Jonathan Corbet <corbet@lwn.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Kernel Workflows <workflows@vger.kernel.org>
Cc: Fox Foster <fox@tardis.ed.ac.uk>, Federico Vaga
 <federico.vaga@vaga.pv.it>, =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?=
 <j.neuschaefer@gmx.net>, Randy Dunlap <rdunlap@infradead.org>
References: <20250826003437.7695-2-bagasdotme@gmail.com>
 <87349ed6zj.fsf@trenco.lwn.net>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <87349ed6zj.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/26/25 11:47, Jonathan Corbet wrote:
>> diff --git a/Documentation/process/management-style.rst b/Documentation/process/management-style.rst
>> index dfbc69bf49d435..1381b253b19ef4 100644
>> --- a/Documentation/process/management-style.rst
>> +++ b/Documentation/process/management-style.rst
>> @@ -42,7 +42,7 @@ actually true.
>>   The name of the game is to **avoid** having to make a decision.  In
>>   particular, if somebody tells you "choose (a) or (b), we really need you
>>   to decide on this", you're in trouble as a manager.  The people you
>> -manage had better know the details better than you, so if they come to
>> +manage had better known the details than you, so if they come to
>>   you for a technical decision, you're screwed.  You're clearly not
> 
> This seems actively wrong ... ?
> 

What I thought on the original wording was that the people (i.e. 
developers) know the (technical) details better than their manager.
And yeah, "better" was duplicated.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

