Return-Path: <linux-kernel+bounces-803712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4052B46400
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10151A4500B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38704285406;
	Fri,  5 Sep 2025 19:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="eL5EWMNZ"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00062248176
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 19:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102075; cv=none; b=m5NdWTOgu7HRABt23SzF4SojwC5Zi/3B/2VWgfIYo0oodUiVTtiQ6ZUkL9g8zMNlu5mhj111M8mvlmtGU5Ek2LU9YWOtCnwPg2cPC/Ge81kGyUB+IniucqwBPTsYJmqVESoxKiHh/shs6cil8L2pT0/PqNYOPjs091NDN5o3WXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102075; c=relaxed/simple;
	bh=STm1WeWxux/k9ErGazCiP6pvMOeNUroj5qNzqv2OwyA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RtexM3eEdTIm5ugjBuBIor2ubrVbFYsBf/zCJmNUgUc+bV4MlkWu2+K3zRbhFkIfv+Fi0VfrmM7yLv0BITCNxpZZ8HBlftGgxaO5lttXMdrc8weqDKwMpTQz0YILFb1KLLNimnMLA7RNmI3niLy4pfy7Mw4ZkgPAalUI1qqagsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=eL5EWMNZ; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71d6059f490so25557017b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 12:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757102073; x=1757706873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NnTdCOEg5OXsYY6GJwoHnwWPPG37oz/se7JGI6fcqw=;
        b=eL5EWMNZHIbD1wGo0mi1SMZddzjg0TqTrLegd+/R89CPLoCL+AJjpxIKuAcrT3W625
         hUYjYPwTz3QtKn4k2MHWlCNbKm/ZLGXfxW8Wydd9xcmb0C8Zlba+F1sYLU1zdDKEKvar
         0L60OlPlYReGrj/4nfhPDfaa4iJh3iYelXqdq0dd+mTIPUJAPpQ73tlaqwihePGi59GJ
         QwxNMY0NHPcjhlk8wzDIF0jEPqNpPWQjkA4yR6BYxOGZ9FH2S6h17mn3vmiZcPr9zTjU
         93CFxTGREyt5tJsJm8NabaU6PB1ts+KA+gueA1TVijRgrO7ytP6RozoSnbKLzRYHcLNd
         s9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757102073; x=1757706873;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4NnTdCOEg5OXsYY6GJwoHnwWPPG37oz/se7JGI6fcqw=;
        b=BIWOJPZL5w57IfknOUaB/5VzSmfO05H76rucd2es67fmgKn1olJadx+fZxQoGgI+vJ
         xVGdLoAQ/Vk7Cz7spjKMrizFffQXkid4OKXiICYbtohwSAbPgBBLdxt2sqApxZ3IgHA1
         DhnDp17zwdaXmCr6QFV0XNauAqxu1ImzcPmR3DpikjcXzTRCyU3x77Yxoo0vUN2S3KvI
         rjbbNbPIZfLp0GMl2EZ7Dn+WgxKlxXxO5llQMFlpQPRHtQali6BMgnmo+0bYJL2jz71w
         xdKnjD5/2Wk+EdhbQrzwuTahi523UOnw+RNQeYyf2nzsIvZW1Rva0MxXCT8kEHiNdXsi
         WHkw==
X-Forwarded-Encrypted: i=1; AJvYcCXHlL70TMxnHUlCoQquLChy58l6n0o7qzjuWyqwS5QuUV1XSd0Yt75HXsHq2VtnihTdulaxgtCs7FC+13E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVqO1XsI45JXtR1V2A2QxWb/5Pw4fLwzVuJ5XQBBeInLiJwVSZ
	e6Og26VsQCzaYMWAf5PSjHDM6DPPhifHHX/x8CmNed4aL4u2S6NNFbd1tEXy+LY0cZQ=
X-Gm-Gg: ASbGncsvOnlcmNxBZk6MpuWGPYk4zjbiClhsxn7Xv+TFs615oczHKEAts5Z6+P8ZLgR
	U19Xn98BoA34gkTfMEmbUNsxZe33YxVdLYhT1211Y3Q0HQutOMY3hfaF8vb4XS6FOrkdfYtZuMa
	ICCOmlbOrCBSZKQ+NBSO9rFMq33C7WPvQ9v+4p7H2xTgPRTwl8qH4fToFpVEbjd0UihNIqAKJGa
	vMBAu1cSZ+dKNK9fK7da17QacJDcWUBOjayaNuN2u3XhZArDiOZ9cWK5TYFGBmvlcOYLTlROcks
	0+sqOl0/1USyQlk583fNbxK83XygDWn7BzxjNYKl7moSws430b0EQ1LjY3G96/lwNehiFrbCi4Z
	Sb88TgUC2P6m3pft0yDSwYM4W5w==
X-Google-Smtp-Source: AGHT+IFS6bxmxveB0S+gbdE1esXUwfY0MdW4w9rHkaICFKEHHTpXWj9UllIVCZDVFVQ47O6PC0q21w==
X-Received: by 2002:a05:690c:296:b0:71b:f6d6:9572 with SMTP id 00721157ae682-727f4b600a7mr898847b3.18.1757102072705;
        Fri, 05 Sep 2025 12:54:32 -0700 (PDT)
Received: from [127.0.0.1] ([50.168.186.2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a85aefcfsm31548457b3.68.2025.09.05.12.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 12:54:32 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: yukuai3@huawei.com, bvanassche@acm.org, ming.lei@redhat.com, 
 nilay@linux.ibm.com, hare@suse.de, Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
In-Reply-To: <20250821060612.1729939-1-yukuai1@huaweicloud.com>
References: <20250821060612.1729939-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH v3 0/2] blk-mq: fix update nr_requests regressions
Message-Id: <175710207227.395498.3249940818566938241.b4-ty@kernel.dk>
Date: Fri, 05 Sep 2025 13:54:32 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Thu, 21 Aug 2025 14:06:10 +0800, Yu Kuai wrote:
> Changes in v3:
>  - call depth_updated() directly in init_sched() method in patch 1;
>  - fix typos in patch 2;
>  - add review for patch 2;
> Changes in v2:
>  - instead of refactor and cleanups and fix updating nr_requests
>  thoroughly, fix the regression in patch 2 the easy way, and dealy
>  refactor and cleanups to next merge window.
> 
> [...]

Applied, thanks!

[1/2] blk-mq: fix elevator depth_updated method
      commit: 7d337eef4affc5e26e0570513168c69ddbc40f92
[2/2] blk-mq: fix blk_mq_tags double free while nr_requests grown
      commit: ba28afbd9eff2a6370f23ef4e6a036ab0cfda409

Best regards,
-- 
Jens Axboe




