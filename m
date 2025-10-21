Return-Path: <linux-kernel+bounces-863456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D45C3BF7E35
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3922F18893A8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4044734C829;
	Tue, 21 Oct 2025 17:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dwns7217"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C11B34C81B
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067365; cv=none; b=HZjtO6GpPV5keRwwRGv+IzWyZs0m70O3/Oy2EICsVPS97v0++DjO+QsvHa9YOyBee0CYOvsK/bxeLHGcb9gXrcEf6MIRnKXruqMXcpLdEwd5hMNtQm8euymp8x3cG/LT1JreCA2leVbtd0VpwJ6uhtUf4GlsuCg/9opI3M6Sln0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067365; c=relaxed/simple;
	bh=G8mckoPFLCNDgpMeg8QaG3P4bXNzis3qzI61jgMIn3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGwF8fR99ii9ZsFPUXa2BKWe9fzK1iEK20zkC1jCYOp7Yd6h+9WWom7jchzl9svxJvKfNY+9HO5hOp5hsQpSnfI1m1SD45ogMTElCKYRR9S7MXaKWT8FB9UV+J8ZIR7DiiHU4FUA30KwQ0xE/Qiz4Q0M304O8JxDcPvE1RT6VY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=dwns7217; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b660019ac2aso824606366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1761067362; x=1761672162; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ggMBBGHDCUPAPA7jaGoEjRt0T/w2dBdmGMiBRgHX+Ao=;
        b=dwns7217ZllBq60mpwsbdVESfA81h/ZyVyfyoqI4Epw3T+urp8ghJpnprHiwulIGx/
         3zCIkKsdYPOdSCuscDhUjsdHOh7xKTN4H1q8x9HVjr5pkMBJL79qbI2O+SCltjMu7M7J
         avgBgZmk73AKRujtOZcUm+0ooLJM6l+hNlK7uEO77AwTaeirQ0nb2PQyRgNqk8KNa3XA
         DwENZw1K7xFvdDo3HFEkvQi8ISuBI/cpy997AXW3UlPLabyux+amjhRwJeSbeJ2G/Ftj
         zi3+u0EFEC9UCVEYuCzttJ6pDbocCR4zyssfAUy9SpdmEAxIEu5PpoZS9zy/cGpTm85y
         7G6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761067362; x=1761672162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ggMBBGHDCUPAPA7jaGoEjRt0T/w2dBdmGMiBRgHX+Ao=;
        b=HXuK3zVIim6/FQ6/KZk/SsqtWyWGT7X/8BQUN+MFA4b1YvE8owUiF4PTPBSdHhNw2B
         E1Lflj1shyRmnw6oPYBiMbvbgcrD1QWMQPEv2oJU/Ar1RJDryv5jORyx5aLYSLQDzaXI
         OdfojnxlLWh1hu/6nP57tIuPPdWdDqbU3Pgjfa8N8KJjkH1QKemZwmPK4UUeduiGGLr5
         ccCX150i4BshLtNDSjaBpYpQzqJwbiWgg8UMV0upgMTjayy2hR/0LhR3+acu7r1KI8aU
         u42RBsgxIaHpxcYht03RKwx23QhreD1BRmiV6wU+n3zVwuSnJ3GekWwYe9dQrnyruDEg
         CXOw==
X-Forwarded-Encrypted: i=1; AJvYcCVO9iW4cQ5D+cVxst88qEuLghHmMLh68AiBpUAtehelGE921ILGSyAKjqVNnIelQ5kGQyqwWMx60sKZ9qE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoLt2TsfWr2VdcwWat6qi9jVqDmrJn5pdHY8xfr21oeKyFSzPu
	DjweZlanhFLgKumgvumaJMABdJbLCDPx0nyDdNIENr0/t6rOaWgUFPpq
X-Gm-Gg: ASbGncso+eO73rZZT355UA2E2GxQ+mFNvlqoOoxnXv5rXKmDbJz+kBsrwt1FPagLMp/
	AsIUx3x2TuAFZqqwYjHpRCPL9i2xwslvy+hcxbzZeGafN5rDAimIsp7zv/LvHVVX9C2B5ETG27q
	+XO2yYiw5TL7VCl9g4asUfLQBdCMXKNTnsxdJumPg0eaX43NX4IMOdUzLtPQvXI/qogcb50YtyD
	MNs65lJNCe2bBwBmJ45gv/5UCeC3NIj1T2PvnM/Lsk9Br4AX7vy9fbXHLuKzFRdKn9Hl3ofNWsZ
	oA+IEiwduh7BrbYx9tJz+YXCpfFKo4KbuyL/CuDetY3/TojYOQ64iaFe6jk66omObzdIHm6/bk+
	tlT2QEd98Hchto0epoxZ7hT9LPQhHmIBiA8AInwpVT5TN38nJ4WFYK5vWLlVgoSvPNYXKcTiB
X-Google-Smtp-Source: AGHT+IFKDcEQuPW4d2ec2CWbLMx6Bu0HCyBun2U/xIz22mZABHYUTeWloU/S+k55rMWly/ntSoWVUA==
X-Received: by 2002:a17:907:9303:b0:b2b:3481:93c8 with SMTP id a640c23a62f3a-b647304ae3fmr1874648266b.19.1761067361568;
        Tue, 21 Oct 2025 10:22:41 -0700 (PDT)
Received: from hp-kozhuh ([2a01:5a8:304:48d5::100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e8395c52sm1117491766b.30.2025.10.21.10.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 10:22:39 -0700 (PDT)
Sender: Zahari Doychev <zahari.doychev@googlemail.com>
Date: Tue, 21 Oct 2025 20:21:32 +0300
From: Zahari Doychev <zahari.doychev@linux.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: donald.hunter@gmail.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, jacob.e.keller@intel.com, ast@fiberby.net, 
	matttbe@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	johannes@sipsolutions.net
Subject: Re: [PATCH 1/4] ynl: samples: add tc filter add example
Message-ID: <uq7r3zj5ys62leti7mynsg667dexwewscdyuhfnabowx7xeaig@xc2dw2uxfcah>
References: <20251018151737.365485-1-zahari.doychev@linux.com>
 <20251018151737.365485-2-zahari.doychev@linux.com>
 <20251020162020.476b9a78@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020162020.476b9a78@kernel.org>

On Mon, Oct 20, 2025 at 04:20:20PM -0700, Jakub Kicinski wrote:
> On Sat, 18 Oct 2025 17:17:34 +0200 Zahari Doychev wrote:
> > Add a simple tool that demonstrates adding a flower filter with two
> > VLAN push actions. This example can be invoked as:
> 
> Could you also do a dump and then delete? Make the sample work as a
> quasi-selftest for YNL? Take a look at the rt-link sample for instance.
> 

sure, I will do that and send an update.

