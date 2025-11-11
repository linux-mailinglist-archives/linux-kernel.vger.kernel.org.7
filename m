Return-Path: <linux-kernel+bounces-895119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBD9C4CFE9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 934954FA33B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66E933BBB7;
	Tue, 11 Nov 2025 10:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQv6Bzir"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A353396E0
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762855924; cv=none; b=TpWSxtQPgWY2nL5lls/e/juKFb9i+OtZB7QqOLgJK9C8WcbXhmYK9ZrbDS49OL4ILvLgJfh8UNNWNZ58hHlSlnUNjXSbiKQ/94XqQGSsomgRFt8mgXRCw9t9nDV5eKZaSr/lEATebK2bzBvxXk3v6PsIfRnPbPcx7NqoemXoFZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762855924; c=relaxed/simple;
	bh=cWnn3n7G8/ZQs0H6Ug8JQGwDw62F6ex97ljlbyAQ24c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSl4sowFfrVbvY8nGyQ2ahhYAVkrLAznhJbl4xmCW/gZVclfxjd967lEJ2w24UoteVzrZnrsqOZtWujjoRiz0RYnrrsS93DGFvKdor5rV2s9JjonxuFC5SOcWMWcQMdWdJBtkle1znNBPZlXypAx4R6EDxlPAb4JAJ26RriYeVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQv6Bzir; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso20432495e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762855921; x=1763460721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zpA0nsAl2y64fFui8T2QPj854ryG2rBJcondGAYGJDY=;
        b=FQv6BzirHgXlpfxk3iO82cSIHmcsXUuCwuJkRgPeYgW0W1w5EqnEQTeSNCRyRBBtE/
         J0cbZTEHeP3T+Dz+/xQzkGzFogQYVzWHpRD+cnnfF6KphsbyUCZLdNpkOQLaaqBt5nEN
         lDMxTZJmlJQubsdH64yOzybo/jbWUSBGKNT/lhMYvq7lNGkM4QBObWtHApebsO2+Kg+8
         wBl31VkErnFXR6dBkOLjRs2heCwimI0WSeXzclSq0TLAE8ElTn5VyExUVVVjQ3thWZd6
         2i8n1y7sYij+Gr0i2OTnoUfKbVRDY0HbzUipdMXM6j8h7mIlFPI9dooUL1JDG200Ck6R
         rrUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762855921; x=1763460721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zpA0nsAl2y64fFui8T2QPj854ryG2rBJcondGAYGJDY=;
        b=AxAR0ZQXKgpDlj9ifB4fOrmnWFDW0JrfcjybdZMbT3oEcTyEZ4TTlosQZqG2eVbyVw
         KGVigZa1CrIRWh9PlAISB6hgzP2+1MRZDDJSU/OeKaZ2nN6+yF7jhjDfMiC3e2T1cZ7Y
         FD2R/i6eYKNt0tPCs0+NCfTVsD55tsc8YTog+w2eR0mq75EmgWJbSS8Uhj+irjroWc2D
         zYcOBEKpRbra3qX+8sNd08A8DQRf5dPCeWePT9QUkwOFGpmJzhG1A1hSQ3yl9IQYQNDX
         WrXykgj5tqOF2/W4eDEBgsC9MRjk+6HkAYmoZAiRmL9Ruhw/XWo07YjZ3K0XbdOssViC
         dxZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2fyGscaqNzfX0mG1+oGizVNvIjf4FAA3/QgzpoUUSfAruSSsQ10QPSR/lYSvcN2+akQZuCzl9RTbhdk8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9u5n2LOUrP5a1Ywod0Lwg804zFeVaWEE5KPFfxbLrRSGxP7CV
	tz9mkbrBSnsn7DfikOxKnXXqG/2iLx7eAdvjML5iRlIMYdG+8H5JOonO
X-Gm-Gg: ASbGncsi2gEK5HlEXguH1RDBJNc0J0VwM23jFdsjzFgbOoYkpxuSIRJw7VLXtbpI0Qh
	n3kCIuooCCImaH2WKHLuXzrdILx2+eZvcZdgggw3qBlZuyFZDPj6IeUdfmF2Au8L/yV9dc11zqB
	v6K38L0+EBL1BrNnxSurRfsGBLbkRZrhaxoBhzD56VQPK3ZWwt8IXBgWPhgWd1RX8uc5CfFudRI
	W3ja+da4ScWaS4FbLLshlgW8SUcYRjO+Og+CB6ULZttav4vnM6pz+V4inez/UegNa43mFDKMyRC
	JmaSkfgh7Bn55EH0A+w79kPHj7Ws34HihPz3dO/Qwusl5ArILcCrJ20dbMs3HaTsiGJvqivMydt
	pO1/GtmH99vAXV407F+gtTjx8y7db2CGvAtwXHtv634dcuu5dy9QrmX6drii1h+Hf8/WagGVUzX
	QC4PLDSKk=
X-Google-Smtp-Source: AGHT+IGpcr8mTkUZpBA51YENuBc5/Dir5lRsnsgVBIv+niLDCI8lXa7UKITiUWESg5Q0N/JZFhnHAg==
X-Received: by 2002:a05:600c:1f93:b0:477:bb0:751b with SMTP id 5b1f17b1804b1-47773287cedmr101665355e9.27.1762855920606;
        Tue, 11 Nov 2025 02:12:00 -0800 (PST)
Received: from debian ([2a00:79c0:60b:8700:3000:d590:6fca:357f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62b23csm26760999f8f.10.2025.11.11.02.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 02:11:59 -0800 (PST)
Date: Tue, 11 Nov 2025 11:11:57 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: dimitri.fedrau@liebherr.com
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] power: supply: gpio-charger: add support for
 fast-charge timer
Message-ID: <20251111101157.GA3205@debian>
References: <20251022-gpio-charger-timer-v1-0-b557409400f2@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022-gpio-charger-timer-v1-0-b557409400f2@liebherr.com>

Hi Sebastian,

gentle ping, is there a chance for you reviewing the series ?

Best regards,
Dimitri Fedrau

Am Wed, Oct 22, 2025 at 09:47:46PM +0200 schrieb Dimitri Fedrau via B4 Relay:
> On some devices like TIs BQ24081 battery charger it is possible to activate
> or deactivate a fast-charge timer that provides a backup safety for charge
> termination. In case of the BQ24081 it is a fixed 7-hour timer. Add support
> for enabling/disabling the fast-charge timer via GPIO.
> 
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> ---
> Dimitri Fedrau (2):
>       dt-bindings: power: supply: gpio-charger: add support for fast-charge timer
>       power: supply: gpio-charger: add support for fast-charge timer
> 
>  .../ABI/testing/sysfs-class-power-gpio-charger     | 10 ++++++
>  .../bindings/power/supply/gpio-charger.yaml        |  5 +++
>  drivers/power/supply/gpio-charger.c                | 39 ++++++++++++++++++++++
>  3 files changed, 54 insertions(+)
> ---
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> change-id: 20251022-gpio-charger-timer-cddae1619714
> 
> Best regards,
> -- 
> Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> 
> 

