Return-Path: <linux-kernel+bounces-841727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A796BB8109
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 22:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 934334EF167
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 20:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDBE2253EC;
	Fri,  3 Oct 2025 20:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miWdq48k"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2362288F7
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 20:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759522584; cv=none; b=gm+tkNGiKItDk/TPiArosfICYu4mfHIqWbzl1RIVTW0cnEPyBHmKkoVs5lrFKX1CxkxB/BdbSvu60Z7GaxSSgqzieNrEL3DCZtwNdCfiJbbEixucbx9cqowkgWWMuDf7fWOdH1+kXHFCuTXAhTWPoZiDpznubZ10katJ/ih16/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759522584; c=relaxed/simple;
	bh=H82ORd8hr/qh+IsbcypMsoZeBRi/Ei/EMP00ecr4XwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfdRCR848nkas4i5pQ/JpH8SvAXXX5bvwoLNKF0GQPDGlcYbvgvbaUS5JwSc9RgfAqTDSlPcqQeCsrcTEl9PozFty1eOol/wwEJk3Dg3diGd65f3Pir2kHzlBdapZ8sgsWWRz6sIQiqG4ZWKbnnvyxkdDL9Kw5D3DNxfeny4KX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=miWdq48k; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b5a631b9c82so1807450a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 13:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759522582; x=1760127382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VT0KFxIL7C7pHlludN9kedxbqFYyuMwiQOZio+aHSVY=;
        b=miWdq48kMvzPahxv/2I2hwS+3cXcV+SF+Bomf6a8gOlTD+zgu6ilEVfoNVCGVi2nD3
         2p2ZgO7ycjamOk5PXY7hdGQRdQtDP8Ofcu3vrDn51LwCpKrn7/o5Vb7n5KTdTnRj9kKx
         fej2jM2TV5r8Fa4D1aKoLtz/oJGsLIWZQXVJ9ykUXch674ynz45yINW4nCMSrt9/T10a
         P0M9vtsf7F/wQfeiTCaiZj420i0m8mboazidaWkNRo0bv9F7KLtpjraADtg35MQLdhYa
         To3OCEBOSKJ5IOJroEprQQqyMbZInCahZTM+vnIdI7Y4xFO7h9joYmLmA5ZECJFTWNOp
         IwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759522582; x=1760127382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VT0KFxIL7C7pHlludN9kedxbqFYyuMwiQOZio+aHSVY=;
        b=ZzC/EJf0Pjn9ML07g/FUO4HQ4w7W1w5T/17I1FCKgf01ur2ZfccqecE404ppMB9gbo
         /Lr+ROZ6nGt5MbBRkiDZ/QbWvRI71C1Q7d+qsVTZZYjWqL5B1+FTs6oBkK9/9txQY1Bg
         N40tuUNsUintUDLKQuBEOwjSENXw7rEOcJ5mw4p7MI3+koEuOdeAV9iEl6GwUWBMWa5l
         S1z7qy+AcGuk+xIyB5i33ALVWGXVMizVB2A4I2MkJ9H6lIgsheCLbY9VJvx8DlFLYSDn
         UGhbvKGsg8GLlI4nnM3Z/FnqbtvMyouSn+kKjFJYV20GwDeE3/8w+gs0/FYqh42hwjwZ
         n9dg==
X-Forwarded-Encrypted: i=1; AJvYcCWosB5eYtJrX3T9lIkOzQa7/tdkvT41CUFxNCiSEpWyySXniXvOR3HsWBiiHRionSUnO+NvOKiF+EcVF/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgZq0aHGPsTzeVRhEGNmlf5JU1FAI56Lsr0PsWy7MNxKyVTFE2
	87WVSD4Yy92fz2nCimkLMJ8xSR88F7mniALwR5qwqAV+Hl8VB0TYSgWQ
X-Gm-Gg: ASbGncsImrAzuALr0XvUMyppixvwdgb/tLBDe2qstKLa8vwLxqYEX03YcwgQS7AQ+NG
	ht3Zm0c79sOJaZ0iRUKXyPe2TzbzpRAlwMQslpMHYj3ztyWo9tLkbzPuCqG/oWTzs2Rk4K+TQFN
	+LIXH7DNjl5RjffUv9enRSUur6HbBo7qYBIm9pMV/LcbTzUf7tbxyWppZ/B2qNxUY8cc0xqCQ/q
	bgFqJMpB7s7qKkxZKop2CZSc4e2rV0NQJEi4U7XRrx2gcveaEEslr7h4/+LXVNxJ2IJte8Cn5Az
	Qa8nzi3jzpo3qn6f0FCPeg5Wx2I6orWvzs5dVuIbewDeui+DNggFx+4hYKt9Sq65FFIFXUS2Cz/
	Xk/m7xT4hrCIqLUw8Nvww+p5KhIveE6la2NM8afhvd3g4bq8xaO2iI2EOCjs8PTLBhDxPRw==
X-Google-Smtp-Source: AGHT+IHlq2cs9sTsIIqnaPqXRQUWUxlWT7W2DP5KttS/b44KTLj0dCHGzWL4O7j4Y3l7/oRyurJF/w==
X-Received: by 2002:a17:902:f68c:b0:24a:d213:9e74 with SMTP id d9443c01a7336-28e9a634df9mr55325195ad.49.1759522581776;
        Fri, 03 Oct 2025 13:16:21 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d110ceasm59027385ad.15.2025.10.03.13.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 13:16:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 3 Oct 2025 13:16:19 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Eugene Shalygin <eugene.shalygin@gmail.com>
Cc: Paul Heneghan <paul@networks-extra.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: (asus-ec-sensors) add Pro WS TRX50-SAGE WIFI
Message-ID: <7e34002d-4684-4eb8-9228-168f1b6987fd@roeck-us.net>
References: <20251003081002.1013313-1-eugene.shalygin@gmail.com>
 <20251003081002.1013313-2-eugene.shalygin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003081002.1013313-2-eugene.shalygin@gmail.com>

On Fri, Oct 03, 2025 at 10:07:56AM +0200, Eugene Shalygin wrote:
> From: Paul Heneghan <paul@networks-extra.com>
> 
> Added support for Pro WS TRX50-SAGE WIFI motherboard.
> 
> Signed-off-by: Paul Heneghan <paul@networks-extra.com>
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

Applied.

Guenter

