Return-Path: <linux-kernel+bounces-880593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61100C2618F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1764A1B2114C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AF42EFDAF;
	Fri, 31 Oct 2025 16:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqSpD7iz"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CB3229B2A
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 16:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761927434; cv=none; b=Z6eXCnQTciIlU/nOjxhDA2xJ65zl/hD+nGL5fCjzDvZHrpX5aKOVS0J7tYH3q3VOZGv14MWRyCt4d67gQfT009taWb5Bms0bp6gXWQORLFyCSFxl+kCH6CZiXyxrOY01DQEGpI0S0RB1pZS/V2uT3WS5cdx3aqnsxibqtCl7JHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761927434; c=relaxed/simple;
	bh=5BsYaTBEGm1eP1z0cy81Z+LJEzUN8VqUPPKulNrmvsw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PXgdGAg7qwEmVFGclezt9ZGJKJQf5NuQBroL2E4LOhEgj5MVcT4c1+U6EEoP2BVzesrLL1sCe6kXLVqjjQBMYQ4KKqwqWze+supQIhXcyqGHWSsWVup5MfwvGUp1q62pLjCSu1KLXQcKbtUay6GJ0gCH6kFXV/BmOTrl3mCzlRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqSpD7iz; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so1984760f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761927431; x=1762532231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYFVTP1icx+rLXILNRQ/LrLPj0eC+oqOFdLiRt2DMRk=;
        b=CqSpD7iz0UQrx7H+ZDaUTrCnQRThROrQTXU6xWMA8ISA5Cls4csVWGMVQiAlh6gK5T
         JaT9lLEGvf48LlddFuum8wlpxULH2RrVmHA3wr7dasq7Z1m7WAmivIgozBBIsm4Kml/g
         MfbBDNbTuvk17SNjqXsdqgcgdBUjwC5UqTs7l4/yn786jP30zISyL3RyIXMPr29XRTZV
         HtZv80l+jgywDVexnYvXJluoPv3XfxTlvoE+vciu5LItn3ByZOZ4KuRU4wIChhXxJnO1
         t5JmiWtBpTPXJBpFpwtAQdG4qVyFQ/NpoLnpYPQo1KGMXrWLsGkxL6tqogSeQi4LCaP5
         d+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761927431; x=1762532231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GYFVTP1icx+rLXILNRQ/LrLPj0eC+oqOFdLiRt2DMRk=;
        b=gKGm5Y98LeiANV3Ww7PY3bjw910WFochK6xFxrgIBrbbH0Sj9Uu6OA9xx4Y+eBLRdf
         DtulxtTSB0R5yoh9iJyLMMCXsQdPFSmgzJTLY3sAuFwhuqGFPU6mVqcmkpYXA9CeTsxP
         2scCLkAwsZO6ATGHG+v3Kz3FM5XT5U1/fN01jvFEocb+CpjmjQa3aRY61NXMpXbZonnV
         rdpxGy8eO2fvgbAT2RAw6hWf7P6bBuOBEcyRKhGA3MeUML1KtAvaekD+UL4X8OES6cNE
         VLTQgUsaGYXlOMknSyXrmI0YRc8NiSqFlxTo0mljon1MLzAUr0FEq6V3xIAj9yM908Mi
         LjSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYU1tnfBGx+y8pHM5di4slLXos5W35TiNLL8AYP8SuDFsuGrB67tPWhOPIxck71pQhWG3VURswGpbQeDY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvmt0hoJeniFbtFEG/gbtULSGtnmmW9Y8ianpX/xTTc4YXrNAM
	w/2Grn+7bn1cuJEIiesLe2GbyxK8G0AGDowNHVjV6GNoVq5+YnQYwVCQ
X-Gm-Gg: ASbGnctlfEZj5DiYYeVs4Zb5W3n2PnH6oE5l3LUfg8y8GysyEr83CiuC9gI71hLfAKk
	g0wlS9es/YmavCLu/NDRR/7iElp5woQ2eWIrlf9XDTopmQwu9aJMGPwF4uIcNFBCivAUqTOE9zo
	qsi3AgvlDD8Eric1QzexV1NukcAD+JRyw0b3KD6PMuCywiGCgofoBtbOZVQrRa9tUD4/lEcvixJ
	GtfX+pJKq/KHEeeXQEidzlFHHve1CEdJ0ipCVvQDZuYkLn7RIDFbpQDcxuuEgbd9yNAMpMN+swO
	mOAsUD24oZMUJk443vleJ0s0focOfaGXjf/cLcqiMNkoH++q6/wr1DOlDNcOfFzdc/9l1CqxLk9
	4iOd4r6I2w5LnNdzQMU6gUpGyXJnp4D7ughHFhXayy6A55KlqOy7ChWoULJui+5Y1Xq1OEiN3Tt
	Ehbpxc8vfxBmUtfwDB54kO9unoPMfMm3ta7QI9jZNDjmeoWJr5z9/hu9p6BF6+RFY=
X-Google-Smtp-Source: AGHT+IE1QvVzUDEQvTZ8vgcvuRMiftBHLR+AgWdjQfZxoj1a75i4CwLiReZXsttxPkPDJ0TG+ApeQQ==
X-Received: by 2002:a5d:5f93:0:b0:429:b8e2:1064 with SMTP id ffacd0b85a97d-429bd6a9474mr3931177f8f.47.1761927430911;
        Fri, 31 Oct 2025 09:17:10 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13e03d0sm4429347f8f.26.2025.10.31.09.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 09:17:10 -0700 (PDT)
Date: Fri, 31 Oct 2025 16:17:08 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 u.kleine-koenig@baylibre.com, Nicolas Pitre <npitre@baylibre.com>, Peter
 Zijlstra <peterz@infradead.org>, Biju Das <biju.das.jz@bp.renesas.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Thomas
 Gleixner <tglx@linutronix.de>, Li RongQing <lirongqing@baidu.com>, Yu Kuai
 <yukuai3@huawei.com>, Khazhismel Kumykov <khazhy@chromium.org>, Jens Axboe
 <axboe@kernel.dk>, x86@kernel.org
Subject: Re: [PATCH v4 next 0/9] Implement mul_u64_u64_div_u64_roundup()
Message-ID: <20251031161708.312343f8@pumpkin>
In-Reply-To: <20251031135255.GA22251@redhat.com>
References: <20251029173828.3682-1-david.laight.linux@gmail.com>
	<20251031135255.GA22251@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Oct 2025 14:52:56 +0100
Oleg Nesterov <oleg@redhat.com> wrote:

> On 10/29, David Laight wrote:
> >
> > The pwm-stm32.c code wants a 'rounding up' version of mul_u64_u64_div_u64().
> > This can be done simply by adding 'divisor - 1' to the 128bit product.
> > Implement mul_u64_add_u64_div_u64(a, b, c, d) = (a * b + c)/d based on the
> > existing code.
> > Define mul_u64_u64_div_u64(a, b, d) as mul_u64_add_u64_div_u64(a, b, 0, d) and
> > mul_u64_u64_div_u64_roundup(a, b, d) as mul_u64_add_u64_div_u64(a, b, d-1, d).  
> 
> Sorry for the noise. Can't review due to the lack of knowledge.
> But this reminds me... What about
> 
> 	[PATCH v3 1/2] x86/math64: handle #DE in mul_u64_u64_div_u64()
> 	https://lore.kernel.org/all/20250815164055.GA13444@redhat.com
> 
> ?
> 
> should I resend it once again or we don't care?

I'd remembered that as well.
I'll do a new version of that on top as a separate patch.
Probably when this set has been merged further.

	David


