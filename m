Return-Path: <linux-kernel+bounces-830703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20980B9A553
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D482D4C4B73
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1293064AC;
	Wed, 24 Sep 2025 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYRf7YPO"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215F82040B6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758725322; cv=none; b=tB2zXQSkYv8ZE/SogfU+VusETUQx3hMe80iTCjjt11qJLFBUUnFi2C/CkH4cWrPGu5H9zdO1PMBHlkq1rX+ggWqQn94/WCTWYctRKKqIqo+G/dePsQR7+FroUnDYifpZ6Pek8l8aAAwJIqBi1wrlqCB4nhgcyzcI0C4Xmj4A4Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758725322; c=relaxed/simple;
	bh=4IsV7Jk2i0IjnsnSne3q7Zle+vqi25l8etXE7cYgRQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rei7vpx5vBTVPQSk3FPsgpjSGc4kkFY7HoBJyWJx5WZ1Ygkwb7yglNpxiHVW3YnP7Mgesu4oiz0cCQ8H5BurjLNhLdD+Nt5JtAAPMLAw/tvtlTZMBvOu26c8JVMKqWGFo57XWTR61fgVXujs7HZWXWA7rindNPcbBdISNAArt5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYRf7YPO; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77f207d0891so3506679b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758725320; x=1759330120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GJWIOp92/VBWQGa84CQUa//9ShSJrAl7Jpy8tRSqKX0=;
        b=PYRf7YPOpDp+Sp5XALPzKko5U4BXuoL05ILooC3GS51tbK885v5nGFdf2ZPZa/5nTH
         zskN+1o+I+VcFJeWv+N+ar9a70fg1A0WT5y25LqgaxhiwAXaipuF3SNK6RTHBySnREmK
         S1khNGvqshtsEqzeCjU6qtlO3gvPaf4PMDrx6NSZesHzcLNc1cIzPjOnsKIBYy4n6L7V
         2/taPo+kCzzydBkdfSYsOfyKyr5Q5p/m0ZAz7QBOZe1PRyGWzTqeX1Dje0VlUakEyrDc
         2kZjsGFRmAlTJXFPfb/TxO9ulbkNTyKMvTxPvQMOjPZFrSRN8cxeuuX7O4vRe1fESSeo
         I2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758725320; x=1759330120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJWIOp92/VBWQGa84CQUa//9ShSJrAl7Jpy8tRSqKX0=;
        b=oU401OcEzGSZ4LCkliThy9qGaMezrpHNJUkQ5OW9rpIH0uky1qvhkqQnTQ3BGt1NiM
         /ok6F4b8+QBS2q1FVVL5nD2yv9SXi98tyGnucpHqNq57oumLeF7jUYBbKBOkAYjbn5dX
         HgLHdepdiVcsA3XWn6+9BmQ2Jd43TJVcI3SblJDlzWUdzkorj0r71oT8vpjZnxdYD6PB
         rngccHuY+OriP/mSSt2qICM3RVPYf67YjAuUTRDv3IpGFuA7qxJwkp5fdFMxApH5/x5L
         LeCo6JUm2RCEFdIU66pAsJ84hLrGvTPAw3wbdu5MaHfm+4JHE5qUyWmurL0TdKFtYslT
         Bc3g==
X-Forwarded-Encrypted: i=1; AJvYcCUFWrYYkuw0tD4/ddS8nqbefMiWI5eGg7/qOmjvD/LsHVPFhC2fJKy4pcdTQSaVDk6AL6xcrp61zxBP0wY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7axhp37x+BiIKKJRAz9g+ZpI5mZkjy6J415S+weB4STndAMjN
	xunYGxsE9AJOVobDdbSnePu9sPH7bgZwhGnCL/HZlJpjWipjBde29OXj
X-Gm-Gg: ASbGnctElC3GEkEF/VZyEKKikc22f//tw4IF/SJlCRvHMGEC5dwBCKwoJIGcmJAmlM8
	bCMJwvO8xNVvxKwh7TYVOwYkzbd+uK5DdGthgf1VW2PCZd2MXhjwt/M/Z9KLbJBNfgBpXh46pxP
	RXOPecadGT/IsCicOFqBgPucyoY5BPQK8b/yxqPEaQt2uUPomNVfmWfavtzGS0IAz6VY6f3wxK7
	z+/xYWHbTXpEDHuw8m751WYDn13zVuAssqQJ1iFVzryHecnXKzlm3LaxQHzkTJjGDgx2dDv/6EF
	chPV6OpLVVRQsV4bWS4EeHKHmK8zQqYzz1lOud3oz+upKpi+POrgfpafQW8j6NjcfKC2WNM/JUe
	70bAxJ6SWhqr1tXrg1A5nRLwxsAZr/vMxaiM=
X-Google-Smtp-Source: AGHT+IEMIvzVH3zVBoShxM3FTiWizXcSgelVZEcdTmdAc04uIJbP7xXcGfh18a6UZkI4nte1tsvgBQ==
X-Received: by 2002:a05:6a20:431b:b0:249:3006:7567 with SMTP id adf61e73a8af0-2cfe97e9b8amr8934175637.35.1758725320273;
        Wed, 24 Sep 2025 07:48:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b551f3ee095sm14195440a12.34.2025.09.24.07.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 07:48:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 24 Sep 2025 07:48:39 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Eugene Shalygin <eugene.shalygin@gmail.com>
Cc: Ben Copeland <ben.copeland@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: (asus-ec-sensors) increase timeout for
 locking ACPI mutex
Message-ID: <6a9bee4b-58b4-465f-b386-533bb2787cc7@roeck-us.net>
References: <20250923192935.11339-1-eugene.shalygin@gmail.com>
 <20250923192935.11339-3-eugene.shalygin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923192935.11339-3-eugene.shalygin@gmail.com>

On Tue, Sep 23, 2025 at 09:26:56PM +0200, Eugene Shalygin wrote:
> From: Ben Copeland <ben.copeland@linaro.org>
> 
> Some motherboards require more time to acquire the ACPI mutex,
> causing "Failed to acquire mutex" messages to appear in the kernel log.
> Increase the timeout from 500ms to 800ms to accommodate these cases.
> 
> Signed-off-by: Ben Copeland <ben.copeland@linaro.org>
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

Applied.

Guenter

