Return-Path: <linux-kernel+bounces-805078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AC6B483C2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8914C3A64F7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 05:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4AA21FF35;
	Mon,  8 Sep 2025 05:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nzq1Sell"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277511D5147
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 05:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757310513; cv=none; b=k57antmwfoNTXEAWP2blqP04MqdFZDZ+CSpenmHcD3rU6+LloGMR0b5stJrC12huaxTdjozxZvdOYGYm5DxWB/HPC2gp9krYyyT3UBHZx02zuyaKrmaaobUrkIhFXXpF7oKnJP2lYcx+KrHTh/qmXrfbdCCWAO5wS69J9WwrK7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757310513; c=relaxed/simple;
	bh=O8NNu0NVF2vSad/YWy2TjskknzxZXtBC6d6bSAsqhDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDGnD6Z3rpn49gvQVC413azF2yecxLGkR0qHJyxSFXEIFI5DBhVNceLmgJS71/H/qEtdqndJtfo+5O2lsjSmTUMMcqLmITdk7Om9Ytkf+N4UsRnXAjlLPg0+6lu4XLVcqLiMrVgOKIMHAqYJXFHSRTL0PDCxWT3r9Vds070a8Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nzq1Sell; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3e2055ce973so2010213f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 22:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757310509; x=1757915309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bK4xCCUkJgHnNsrWJUX5n2h3qweAwpi9anD1X6vMswc=;
        b=Nzq1SellRDFSk35UDq0FYvz3kWCUysrPZWfWqFTRBnALMoj+tCJmVWn06EWMvelDpV
         3dunj5CowVRTzYmKEaYiPUa/SipNTrg/p1U8RugzBg4VgoULsSr/d4XUm1pVNc/tIXff
         5HtbqC9oe6aXzZUo8nXvAU809E5iP+ax+G5DUB1czi09ZtdOrWX+pahkRwKKUoyQ2sfv
         TLEjZPYeSRf24RKDIMVX+zrLRmLyIiW89t1GR/t4vR8MCmB9cJ7kWg31eZubpRMkj4H5
         4Ew5UwGRVyD+nFwVL8mJiHEQT65EndC0E/OiptYkSTQYg6SzImQTrA0HvUiE4pt2JxcN
         /aQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757310509; x=1757915309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bK4xCCUkJgHnNsrWJUX5n2h3qweAwpi9anD1X6vMswc=;
        b=JZMzzdzshKz2PKYNKmB6KT2SolHbs2ENTcsbgcvvCmsi0YqM36t4WcUIq9+FjqT0jt
         Qm5ItQ0dMSqk4zWRclulEqym042AYi622Yc8UX4xY0oHqdLTx0DRv8R+vreqTGEPHOJQ
         5MYveoX/IDTsp9B4dPPJaRbBmFaa38XZkSoSPmRnVBg8GHTRVSy2rSR5Z35XMD+Viv2K
         jpiEJT5Bb8gYyYMQk6zETpNhNXvmMsE8IL806iMst3U8E17rH0r9YCglXxYiIBSLiKD1
         cwps+bLtIyWn0ISrArHe+o9alu1cvKUyVWMuSGlO0l91BpUMhGMQVDHcOrab8rxfGuI3
         ypEw==
X-Forwarded-Encrypted: i=1; AJvYcCVtyjTiJUUA9WF5geFHPe0KSqtIlmZxPXpvmFT0uzadlodFQpVoyY9muBDtiU8GFY9BX4NcgD2WrezpkKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVwv4Oy8W3l0LNv9m3NmpQ+DhfazS0bG1ThggL5dxqydBiRx7m
	yqo1WdOowU9ATc3PqBDjLJUaj6zHhjYcTH6HP5hpkMieGCqpy1zKhwYpcL5+J8IrlNc=
X-Gm-Gg: ASbGncuXVAu8xhEceWzcb6z2eHIwN2aNEyuPS5S2g3Up5e9NB/y+ZuwSLVJiiKdaFKC
	jCIs5Nt5p+pfUmpafq53sigayo4oDcDgXBmsHOmQMxFV4TpG3UjhNUrJZh94juNAQbh2oYsgSYJ
	lSOZe/qoRW3FsALRROMmEQ9RigxxLsTGfTnL1wIa8o/19TxVB+aiCr+vz3/w23VvjQbT2KYmQe8
	2m0Bc+h+o9uDjdih22pC+XVTwNgTaCgKp28+1IPPCSL0O029kdpSUwkLrd2OpAi5YfdIjq99niK
	AEf63Ze8W3RxZAFE3k2JtrSP3ntYS+ZSQp50Fwn3eG+2XvdBXxCseiRh/EiLVmKExJVqsB9AAnF
	KirbawexNOe+mMULnsK1J7qiAcUQn3dorcnw+fQ==
X-Google-Smtp-Source: AGHT+IEEWpQsJ4943vbis4w2dbJY/QBn55s5lkkvnQbqeLGZJhfjukVhzvhNNq/IsiNBzEyJkqP93A==
X-Received: by 2002:a5d:6e46:0:b0:3e7:46bf:f8bd with SMTP id ffacd0b85a97d-3e746bfff15mr1956825f8f.23.1757310509421;
        Sun, 07 Sep 2025 22:48:29 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3d95df59e50sm25155604f8f.23.2025.09.07.22.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 22:48:29 -0700 (PDT)
Date: Mon, 8 Sep 2025 08:48:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jai Luthra <jai.luthra@ideasonboard.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-list@raspberrypi.com,
	Stefan Wahren <wahrenst@gmx.net>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: Re: [PATCH v2 0/5] staging: Destage VCHIQ interface and MMAL
Message-ID: <aL5uKTiEYZP68xLd@stanley.mountain>
References: <20250907-vchiq-destage-v2-0-6884505dca78@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250907-vchiq-destage-v2-0-6884505dca78@ideasonboard.com>

It's really hard to review the code when it's just sigle line like
this:

>  .../raspberrypi/vchiq-interface}/vchiq_arm.c       |    9 +-

It's also a head ache to do a cat -n filename and then copy and paste
it into an email message...  I thought there was a trick to make the
diff show up in the email?

regards,
dan carpenter


