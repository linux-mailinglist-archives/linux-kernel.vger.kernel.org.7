Return-Path: <linux-kernel+bounces-774424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7A3B2B207
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11875526111
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67C21F1932;
	Mon, 18 Aug 2025 20:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dvVaJmpA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C461E868
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 20:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755547335; cv=none; b=TmiSU69KDZDD6kgLL4HLkXw4FHsWJa9Ht5Hy8y5B2fUhoWNMHkxFLqQjDc787VPEVOLy6YgaB2bE8ATmTH6FfXQCsaAJD13nrpIwfu+RIG8XJ2DhV6NzkK1MP5UnmLhSzgCzSFHj1UOb8n3a2daT9IFRGoVnj1KRcbq3pGgrBb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755547335; c=relaxed/simple;
	bh=qjmLUZjHQ5QD9oJntM9nVj7N7ya7TqMjrnF99c2YdS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M1JWHjbRNvMJlYQASyzpEOpFJXTigsP3yFl4Cyxw3hcPMFlDA5g9Ta0xp9/vCm3waLYWch2ewtK73HSSMrNxdo8xe5Nt/qvlWrlr2r0aIJFjLxw+xJFWZIxRYgMnrGJp706IOtGMK8zBT0cboeR1V8A0wD9C7ghbqiH1sAvcD0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dvVaJmpA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755547332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+fG5ZGl1C62cZQFaAJ90q87NcBu2h7Rp+foxmE8Ttek=;
	b=dvVaJmpAuJfSkUAcngRfzMOLLgRjRGfSTRz60i11JxBKVngadB5sZg2b0MbZvsgIQGmmpc
	GfoJFQ37Av6EibHcQ+7LLwn48uoV/diuEtXsGCZdvNJhT+q2TPtkimLWyNR2IgRcq+wRnt
	uzhvv6RbADOmXeWCDDoKPtmo0cAYav4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-GhhZlo6RM-eriJXObtcUXg-1; Mon, 18 Aug 2025 16:02:11 -0400
X-MC-Unique: GhhZlo6RM-eriJXObtcUXg-1
X-Mimecast-MFC-AGG-ID: GhhZlo6RM-eriJXObtcUXg_1755547330
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6188b5b2c03so3530816a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:02:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755547330; x=1756152130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+fG5ZGl1C62cZQFaAJ90q87NcBu2h7Rp+foxmE8Ttek=;
        b=L4YN/56DL/fmklShFnHTjDgKb2xWvWKy3Dx82FxypcgTdzplPMCQoZ5ZR2gNKVB6sS
         lyA40akCmvSuw7JbCU0phbot1f4XRt/cjXOo0wWkryERm8o1rIMtJ8RBmOjEsYP1pIpn
         uOqQM0085saz1zJQ3NP3T79QlS+AUZ/AsdxlpeSpR+vLxFIsKOFYiBPl+7T/NEQCN4i+
         vfuBaXr2/b3PBwcatr8BFPzlGaTJnvVubSBKQqTmTUod4ijOpuaFj7+lKgprXlMBx3GZ
         yGOLEzlbeG14xvmaq/Cnkc3Z7X7Uxn+PwDPepVa4Yv14A1MjS/+XJIhkR/i/W5wYnIlU
         sYZA==
X-Forwarded-Encrypted: i=1; AJvYcCVsMKLEYnp6fWryrrbZUirUI9cd88upR60DPRM0A/2QfXdNJGkukE04a+1A+RbQeYttUB/XeA7vlWmK27k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxv9eeTZHHhR0wMy61OWEJjmwR/sMXUJ8V4uDcLRfQS2UBZDSn
	ipHk/OV26g7fFzLz/AuFJlV4FHdz/3LM3bdGb6LGY3GNktyE62lI6Az+WAfK1PlzXbDumoGwUF7
	GJ+eSqm9TsLngvhOp73E+TSHjTVhOzUY+4hg59Gc3fXErcjHIo6PFfzWRU17KDBlzaVv4K6NNGM
	jX32ZScBB8rRT8OGPR1AMoIzdJn+r+jpFIE+BOi+l3
X-Gm-Gg: ASbGncvGCvdf82xz72dInFTVs/RU6roQiMaHzmEEMMTPdONeYsZTN//UzR4QuDmz+tR
	IEhl2T+yHAGz0HWNrt9zzWFvt3KAL2x/RWI6ZSbpQ1IgLEheezgX2S0xOpSfSJKmsQswmFmek/6
	6hr9Y9DdOhggheNn/d1EhtW/bGD+8E
X-Received: by 2002:a17:907:6e9e:b0:af9:566c:4cd1 with SMTP id a640c23a62f3a-afddcb815ffmr6649966b.24.1755547329838;
        Mon, 18 Aug 2025 13:02:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/Z6YJYYcpHHX5vpa68pR+vUhD0YFs4ADGuF96s+2h4oESeiqbIO9Y8YyPLEqoOxV16y8wZ3QXEoGXDLW/TU4=
X-Received: by 2002:a17:907:6e9e:b0:af9:566c:4cd1 with SMTP id
 a640c23a62f3a-afddcb815ffmr6647666b.24.1755547329385; Mon, 18 Aug 2025
 13:02:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812-clk-tests-docs-v3-0-054aed58dcd3@redhat.com> <20250812-clk-tests-docs-v3-3-054aed58dcd3@redhat.com>
In-Reply-To: <20250812-clk-tests-docs-v3-3-054aed58dcd3@redhat.com>
From: Brian Masney <bmasney@redhat.com>
Date: Mon, 18 Aug 2025 16:01:56 -0400
X-Gm-Features: Ac12FXxrVE5SCQ9rFBJfDNiF5LVNb7p52sPwt4Nq3ZChgQz7oePbloiikJEf1XA
Message-ID: <CABx5tq+yDZ2GL+ekvQAXHGXUbFF3KfwN5ts5020RpYFYZNcUzg@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] clk: test: introduce clk_dummy_div for a mock divider
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Maxime Ripard <mripard@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 10:40=E2=80=AFAM Brian Masney <bmasney@redhat.com> =
wrote:
> +static long clk_dummy_div_round_rate(struct clk_hw *hw, unsigned long ra=
te,
> +                                    unsigned long *parent_rate)
> +{
> +       return divider_round_rate(hw, rate, parent_rate, NULL,
> +                                 CLK_DUMMY_DIV_WIDTH, CLK_DUMMY_DIV_FLAG=
S);
> +}

I sent the wrong version of this patch with the round_rate instead of
the determine_rate implementation. Kind of ironic given that I posted
various series across the kernel to get rid of round_rate!

Brian


