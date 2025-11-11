Return-Path: <linux-kernel+bounces-895456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B05C4DFE7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4A2C18C3DE8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA6033ADA6;
	Tue, 11 Nov 2025 12:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOk5nSJo"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BF732826A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762865274; cv=none; b=oDKsyh+K0J28GIRSJWHzX/0dSo9QJ9Hghv/0qiGoC7FzSLQi1ON74CNp0L5gwoFiQPYMH5dckncW4fb+TpYaH3dp3NeJl+DU7FGJq0aSvqy/B7p/UYnB1pZajdEgAHFZmF/T1BhLXp6lWygpQAD0KN9i2whMncXIV++fZZtieCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762865274; c=relaxed/simple;
	bh=NMzltJ+8qhJWfdVf0suMn2FF+So0nIWjDZ/N6Yui4sY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PWwnVlj9jHfsaPXhXfOk2y4cjzgijBzO8Kfp+87RL2jSx8wc5wfVsoinGI151vzCge0uPSTiFO5jGjzXxyD1bCoaOZBLpHaQNfrXkQwvwDGOdl0Cuj87rbhJWGa4EdZT9xhcqHU9d4QYtn8BjqvtzPWAju1QF9ym6+ELnvD4o8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOk5nSJo; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b3c2c748bc8so521533366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 04:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762865271; x=1763470071; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NMzltJ+8qhJWfdVf0suMn2FF+So0nIWjDZ/N6Yui4sY=;
        b=FOk5nSJoQjCABGf/sAQ/B20xKRrjjzuVFux5FDtYHfJmC+xnmTh1dtMrDF6UeAR/WF
         BiK82c2sdHROsJ2oUWIM2cnG834hTGNhcXCn2F9sGchGrHU+wRVf/quAtsAW317w4Spv
         pzJDBy2ejovyN95vUNSUgWanj5LCIRhY8Mq1NJ1FuwEkbLgIezViO0BOhf2X408j5JhE
         YujDkfwwt24qTzOOHp4+voMv6LXJtJJ13MNIPDLU2XuhmNj1XBFn+33p9XRzLjgrfos3
         HtKfPZkjX+I6v4YzutV5f27+cKn/jjUAcGjpOgmd7OLaZUtmHBNVEaqhppYeZXC/B8fE
         mx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762865271; x=1763470071;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMzltJ+8qhJWfdVf0suMn2FF+So0nIWjDZ/N6Yui4sY=;
        b=Wd736rxoau989gNbSfGttY0IYS8hEhVvdD+PK1MbRn9BDXTOQVIAM6cZx9+HFokaIP
         xj7ITeb9Vt6gze2MLbn7jqwgHvFhsguJ9n/vIj3m2rB0AOwUcH333OZTXmw6c0tfCD8J
         Frdym8aIovhjWK2eoeeAOqkl6p8CeAUojVBq8xdP4bQ0AFjAtOlsskFa7OgPMInmP93R
         GC1oyFjis1GlE7KvVe+1P2mqHaPvUhuDvVFNEO0MgtbgBzK2//pq/fgIVs4neSfWKTP4
         GUVvH+NxcPGNO6hpN5aTAYGnl5CSju7mr/i9KMvtxNMaxWWL1+hCA9XmLw0eXvCJqv/5
         l1Jg==
X-Forwarded-Encrypted: i=1; AJvYcCW5RyVyEkjLeLgRtC4/Jas2aLQ+eTIhDjfH0NN1IDjb+OC0xtFrKXSHTrHYGXCsU/rVQgSulwPLA5uiVao=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZrzjPoc8YHNgfSlG+ae5knRvq62/gMdasoTk12ZqdDnW9AY3t
	kfVBp8aroBsRwaRVD69/L5Gpyr3jKSetMC490h6nfYYfy4INoKS4t1RTMekGY0rScGFwNYSa1pS
	7sGS3hIi4CfaoUjUTYQDaKcPOxDi4JpU=
X-Gm-Gg: ASbGncsGMu7Vcxf2j6TEUNJ9QLkWxHzhb51yA4DTg5K4MO9yyogmRTrYP4eoEcrz9pZ
	n+u3zWtfoL/a1ZHKM9178ro0QovvqAigt/YQh9cxMtTOTTqpJSXooWp70pjte0pJiHdJcQDCnR0
	Lh5ba5EDy/I9CMGFX/t9ShVvhiqBRe62jLMSQ8CuLXIJeY4IGqqrXndthd2H3pIDDyu/HRdiLPl
	vPJgn4QIjPU72OKq0bbKTUPUhA/YVR+Ap6TG/aKD5tepuq+UGL6xtAazBSg
X-Google-Smtp-Source: AGHT+IGiAQgwMVRiGCnMiDWwUKJTp3VVUil3hi7anG6LPGbxJTxQiXv+QsMmKl7eVBT6UKFdaroeoqA7jwP8sNFm9RI=
X-Received: by 2002:a17:907:96a6:b0:b65:b9fb:e4a7 with SMTP id
 a640c23a62f3a-b72e02b337fmr1061707966b.9.1762865270901; Tue, 11 Nov 2025
 04:47:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122023745.584995-1-2045gemini@gmail.com> <20250123071201.3d38d8f6@kernel.org>
 <CAOPYjvbqkDwMt-PdUOhQXQtZEBvryCjyQ3O1=TNtwrYWdhzb2g@mail.gmail.com>
In-Reply-To: <CAOPYjvbqkDwMt-PdUOhQXQtZEBvryCjyQ3O1=TNtwrYWdhzb2g@mail.gmail.com>
From: Gui-Dong Han <2045gemini@gmail.com>
Date: Tue, 11 Nov 2025 20:47:14 +0800
X-Gm-Features: AWmQ_bl7jKmbrVcAN8OrZV0RsO9xo9Mq7861gNjqd0U45fWXiyojg8RitqkJLAo
Message-ID: <CAOPYjvbEbrU6qOewg4Ddc8CBDjmXous=PbgFF+5cQHf98Jtftw@mail.gmail.com>
Subject: Re: [PATCH v2] atm/fore200e: Fix possible data race in fore200e_open()
To: Jakub Kicinski <kuba@kernel.org>
Cc: 3chas3@gmail.com, linux-atm-general@lists.sourceforge.net, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, 
	horms@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jakub and Simon,

I was organizing my emails and noticed this v2 patch from January.
Simon kindly provided a "Reviewed-by" tag for it.

It seems this patch may have been overlooked and was not merged.
I checked the current upstream tree, and the data race in
fore200e_open() (accessing fore200e->available_cell_rate
without the rate_mtx lock in the error path) still exists.

Could you please take another look and consider this patch for merging?

Thank you,
Gui-Dong Han

