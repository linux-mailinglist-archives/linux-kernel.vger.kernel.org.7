Return-Path: <linux-kernel+bounces-817960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD93B589CE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C7387A6699
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 00:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7D71A2545;
	Tue, 16 Sep 2025 00:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="No1Z87U1"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2909A1A0711
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 00:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983131; cv=none; b=cQh214N7Lx/TiEUkFyg4xYjM0yTHYn6cGW+5seXtepUvPoSGNbyr11CZ60bzmBHBrrUApRnSJDtrHyf4MAcPrvA0MZc7I40x4v18JC5nH7Aw2R9y+XWzwgEJGz3r7x8G6o8GF9dCC7lCcKmRbbLb9LjrrBTmB2QKz2C5/XiK7sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983131; c=relaxed/simple;
	bh=fCfZk5qBctW39PFDrEg1ReclqN41xzGlJWi8/4C79r8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZH9WDx97LTUFMFWhSi0E+Re1x5MY0Jt2qQlVsy05+yNEXgKGQ0XRjgASxcY2yDXU8D8+KltzBda0J7YuVnXUHJOITbXLA0BbsU9qVXSz4x7TG/t+6xD8u1hgxu9Xhjz7Wu+5Au92qjsTaf+rdeRwYjYnqhNGPxBUxtHGVT6WUsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=No1Z87U1; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-26488308cf5so14721385ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 17:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757983129; x=1758587929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wzTy1GEKlTZD9blTzB9EKyxfAV8idgtoLZgPRKdhUSI=;
        b=No1Z87U1ExPhpfVQJPmYZC14R9tZsjFfprjdfcgkP7g6FU0BpY95+NxXTMzPOH/p14
         6He4GqfIa0ZlBldZhtK/9GA3NXwLtc46Ce+kbUQaz9hyywewMe8v0wbr437uGFNuit8n
         LodnryL0ikUBqGteyPzosGihY9fb3q42gqiGdbJNxfJQRTOXqSeMUrkMAj7lid7n+l/4
         LWi+366EM70mOWDPxap5zOEyq+Q01DoAXJ9miXGJ0Chr4BzcgMQX9aqX4l83LbPgBrPL
         9LQ/05BiTreCx+H2hePMLC+pPM1mRefYD2MGiA4t4gwHM2zsdGesLwjYOsgnMnWo6GCo
         sWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757983129; x=1758587929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzTy1GEKlTZD9blTzB9EKyxfAV8idgtoLZgPRKdhUSI=;
        b=i/4cMYMarG4ZNnuCNmbgkUIbcDNZKE5Z9XxrH5oMx/lpJ6VyAeVIaTBtVdlznpYnse
         1my2Q8+h7rKihl/mwQvB43vGkZie+PyrW9ZFpRV95eimtEk4SY4IQWQyQGBtHjT9PN1i
         sxLYndCBV6kozhiUTbUUnGYLFP0iYLwTnb5IDNhmbk/6rg1/DR1HGs4YwFe3psDX3ARB
         lKhxu8Lke6222LleuObSoz+H2hKTJTrapg3YvPjZdYiNDETcVC0JKkO3tXxWdxVw2bhq
         golYHJZN06dg5VUOTzyb4bQ2NjDpCRMhpU6KaI/Ufvfxe/61GN3i+fuRBlgcUq+RitL9
         lmhw==
X-Gm-Message-State: AOJu0Yz+ddCDEaeCVKHME639S4kRbYTGMy/klujZtV6rhNNSH0NEBrAQ
	dNJC7iMrcuISjK/bIAyM6v7hcYarSKebxiZCP6QB4kirZHyRK6zakH/6
X-Gm-Gg: ASbGncsmJ7WHndW1/jwcOBPH8d4Nv5nlPyo0TGG9udXOmdNUsxpjUzZ0fnw3uS0bv7v
	atJ/Q3d3dfNj9DY0aS2/R6CB0WnJjqE0vWznxkV+M7a1yvZ84+EvnYe95BKeW/JfXawZcyFle4f
	7i9WeS9TlUns9dWzUrBEGzAZIFCQogGByqky7sSgCKSYzYdRBcxuX9IHz+mHqnmmvoGZhHpAh3t
	DUmguUXDQ8mDcBfd32wB1DHZGD3dDWeTmfCPc7MMZFoa5aL9jZOUmQSeOOiIMILnI28B4yRPHI3
	81UxsY7eT/3JC2rmJ7mbu6iYxF86+BNIIGmPtmssSE69soG47AmhfFDmVoTLHuqXfcZvuSMeXrK
	3EQ/TURHA3PmjVU5yPuRMTd2Kr1QNFL75ug==
X-Google-Smtp-Source: AGHT+IEbcZ/tyusr3scpobNc9upgjYfXNOlqeZDVXTTcmyrv4QOc4h+s97sfIzG789CN3nRJFtRoOA==
X-Received: by 2002:a17:902:dacd:b0:25d:8043:781d with SMTP id d9443c01a7336-25d804381bcmr172273595ad.21.1757983129260;
        Mon, 15 Sep 2025 17:38:49 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:df19:cd01:3e91:19aa])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd6306edfsm16270991a91.18.2025.09.15.17.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 17:38:48 -0700 (PDT)
Date: Mon, 15 Sep 2025 17:38:46 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Al Viro <viro@zeniv.linux.org.uk>, Oliver Graute <oliver.graute@kococonnector.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Yu Jiaoliang <yujiaoliang@vivo.com>, linux-input@vger.kernel.org
Subject: Re: [PATCH 2/2] Input: edt-ft5x06 - rename sysfs attribute
 report_rate to report_rate_hz
Message-ID: <it26gfh7qwemksyqw3btcqyr4obbviwaywmyptsjedil2v52vi@rylzlifvans5>
References: <20250915201748.1712822-1-dario.binacchi@amarulasolutions.com>
 <20250915201748.1712822-2-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915201748.1712822-2-dario.binacchi@amarulasolutions.com>

Hi Dario,

On Mon, Sep 15, 2025 at 10:16:32PM +0200, Dario Binacchi wrote:
> The sysfs attribute has been renamed to report_rate_hz to match the
> report-rate-hz property from device tree, making it clear that the same
> parameter can be set via sysfs or device tree and behaves identically.

No, this attribute was defined since forever and we should avoid
gratuitous renames: they will break existing users. 

Thanks.

-- 
Dmitry

