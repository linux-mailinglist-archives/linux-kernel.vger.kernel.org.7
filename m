Return-Path: <linux-kernel+bounces-790746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE516B3AC80
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 23:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 959831C21ADC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB462C235A;
	Thu, 28 Aug 2025 21:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GszRXMLh"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE078293B75;
	Thu, 28 Aug 2025 21:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756415252; cv=none; b=HJAikFScsa+KrmTo8dTp/ssC0aNqrc1qTmhjyG/NIibqfqSUTUGK3OoH8iTXQdv1ZfnTLONhEN0NFDsukT0v+OZxO52ZDESPFafZEF3yVbarchYDPwbfK4JBgfqUtinwjacZzNbwe4s0mmmOXLvjKip9/s25izJUKVzhPSIR2vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756415252; c=relaxed/simple;
	bh=ofbsM7xQqlSA5ltgmkTYoU5eIhs0ICZqz5jfNtIFoeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwq0laWwC0DZWDklR2flaxY8x2PVQ0Tm97jOUcvzJoAsEW0b76bILr2asU7Spgcobpde/Er2eGOrHzzeu1jpxC3SR0rI7HTPmX0rhthqvqQywhyLa6oANRWlA1NEyx016ec43PmqkEAOOVGLWjvHNw9XR337YL8Dz6nxQPB83IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GszRXMLh; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-248cb0b37dfso14134395ad.3;
        Thu, 28 Aug 2025 14:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756415250; x=1757020050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BjL86Fze1R7sJJFQIUzDTcJaqf7BgddrD0Deu+Sh408=;
        b=GszRXMLh2NBPauh6fEkKxqeMUD2Z7tiRNOB1qUfB3OJVbOiZEZApjnEBbRueVrHmfv
         TnsG17lzzdOvVR4RnVus3tO1fh/uHh24b17mUXaeac44vo9aR5HHdpUhRFTwFXC7i4dy
         QNNeuUKnuUZo7AqkGxOKcxVM5PQH2q1DqVab3gJgrHI1LK5V+8s5WhDZt/CLFEH/TWGA
         I08Q/H/AahaYwOZpgkaL2etssu32Gdl2/WaIY9rGcWK4DLwwn7Ry15/ysJTH1qYDqbx2
         O+oWehH04HEGijc20lBYw46Zk47ai7lQD8j01LYZP60Z1Iq0Bsc0xcloORkaJul9CetO
         QVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756415250; x=1757020050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BjL86Fze1R7sJJFQIUzDTcJaqf7BgddrD0Deu+Sh408=;
        b=BTfTMrC5F64q+zUzo95SnqsyGHVR8rZ6W1TWsDCtqF9CbSWakhDng099QJETrmqut1
         KmTQhj2LP9zz1YesBW5dI8H9JeVZhQC1G+dqR52fmSaOfhjzzW/+NBkFZh9UwyA90LE1
         1WioeecmSTIZ7edzXhaCBX1rvAbj/FnXGlw64syNFg1W79tWsXrSuZsB11IKRYxtRGxm
         5kq6jErp1uLhFR6ZfgFpNDGp7FiOJixyujMWNj6Ar7tHD19a2Y2zhiuSNUyv4Kc/Ni7a
         r2y2tJ+LK7ZX8HxCIzd5jGUTFsMi1x3pQVP9hFH8gxKz/99d7Om0Joc+jbF8vXpm8Lx6
         4Ohw==
X-Forwarded-Encrypted: i=1; AJvYcCU9sxq12rpJruzbxamQOvQuecstVxXgMa3rOpFowv7F7ht6U5qjMlNU12hYaVTIKb60LQ+9ipdMpr703tU=@vger.kernel.org, AJvYcCUESIQIcusN1g5Yo9hcOrO4PeToY8l5nMRsTmsKIU4rdGEgfNtDco8qMK50mMO0XxOz9GldlJY+Hj8z@vger.kernel.org, AJvYcCVkflaucb31ITyJOBhP4l9uOLVfuM+4lbOwCAPTJvuZwDx60PsWMAR03u7t4kI/JRuT+dMI4OrmIb7STdgM@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhtk6NGfoZPivVTEtVtolDv7FFmqPV9psUPvWowNo5sr0o+RsB
	1TTrWd9KRai7xzgYBKRQMkwMdxAS/qr8LVQ2PkiiO5kbwbYGoa4NiO/dj7T5fQ==
X-Gm-Gg: ASbGncuEIwRvkjSEkxVVxcoADcP8xm0lKKJHbxPE8+sSZDX2UQbQKJFzqxjIaLqfUbN
	bzk1NzjHKEpLHQmLpZol+KctDKloNfvDyAa5y24iWIjhFwMVesOnuw14hIy1Gv2n1l/8DuNg6W3
	w+7yw0ZWBufJg6/F0+kS7dkizhGBmneqHBM57cU2j6A+CiqdTZ2LjiMsyMlE6/4LjFOHQBiUQbV
	xkytgEumoZYzxJHlf/50L8gbnKES9KBm9BL7CTHBAxjqKBxCuYYBDT/ct/xGO4NTxIUYb9dllOI
	rLzVKw4ROVqgXTQ+1L7Br53pm8woctocKX53zj6IrVztNAHkZhHW0iAH+1PLh5ozOfWp81mU0pU
	ARfodWmzMwndnM3L7+tSm2ztsDvbPoLV8g1M=
X-Google-Smtp-Source: AGHT+IHK7WsgT3t3J0taPKEA/wjBT3gY30wg7LkuEn2udE+tE9xnrQ2Ows6M6cEJepJUjfEmCSShnQ==
X-Received: by 2002:a17:903:3d0f:b0:246:7711:87e with SMTP id d9443c01a7336-24677110bbcmr257839135ad.21.1756415249892;
        Thu, 28 Aug 2025 14:07:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24906395aa0sm4402265ad.100.2025.08.28.14.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 14:07:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 28 Aug 2025 14:07:28 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Grant Peltier <grantpeltier93@gmail.com>
Cc: grant.peltier.jg@renesas.com, robh@kernel.org, conor+dt@kernel.org,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] hwmon: (pmbus/isl68137) add support for Renesas
 RAA228244 and RAA228246
Message-ID: <31365758-6cd5-46d5-bc99-c7cdaa7f7b5b@roeck-us.net>
References: <cover.1756331945.git.grantpeltier93@gmail.com>
 <70bb08e291bd57722b1b0edf732cd0017714ef07.1756331945.git.grantpeltier93@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70bb08e291bd57722b1b0edf732cd0017714ef07.1756331945.git.grantpeltier93@gmail.com>

On Wed, Aug 27, 2025 at 05:41:36PM -0500, Grant Peltier wrote:
> The RAA228244 and RAA228246 are both recently released digital dual-output
> multiphase PWM controllers.
> 
> Signed-off-by: Grant Peltier <grantpeltier93@gmail.com>

Applied.

Guenter

