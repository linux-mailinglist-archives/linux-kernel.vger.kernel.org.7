Return-Path: <linux-kernel+bounces-745959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F468B120F5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D08818946D7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E552EE966;
	Fri, 25 Jul 2025 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaymrLCw"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5810A2EE61D
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 15:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753457377; cv=none; b=MSv88OSCbAFYUrlNT4zxbYuaGKYJotvmVIJsTER+wYN5XfV76o4YdfS2Wh0DLkIKlo5rSUWU0ST99/6J+4r/KDPMEu14wRQiUh61u+YJJMIgRczTGdW8dm1e4GdcTu5Sp5L5denW2Jh7wdKVlQ37Ym2we3B+5jcuC917th/mCXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753457377; c=relaxed/simple;
	bh=rfV+Zm+Mb8q0Xqs52mwlGZV13ETEQ7K4+Cj/aArnfPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQh42DB6PTeqo25uzi4580fsq7qB72f3QNR10aiIdyLAQ8lJH7i+hd70SOvrbP9OlCICnBLC7wPasQp4eMNT9oZ4d+m/cb29g/BcwrnpD+e4rSwRjhD34VkoWXUkMYNijzmui7dRPmlK9gYRMmlpogJc+VhwC18WuXAZb5cxF1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SaymrLCw; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a54700a463so1437783f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 08:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753457373; x=1754062173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfV+Zm+Mb8q0Xqs52mwlGZV13ETEQ7K4+Cj/aArnfPE=;
        b=SaymrLCwAesPGTz02e78LzuoX1ftbi7DLbN1A+w+XOILc7dkw7+Dz1fh7dTcS861O9
         80KPu0xfGi3+ztgm7ca0sW/3UULCQfVnKH4y33XAHNmGS6CZyVRoMvypsEWsOFsGo+YK
         aIDlNq0RDqzPUQcoiZK3J1iuZ6nZG4BR/1AvrGqdsUo3sMZ5MBq1JfbdV8ooSfgE98qr
         j5Zy+talZ/57kwwXqd4Xj5vbm+fInkQjyhapGTDkZkFDCeaResePMogHKPx7kgO0IP9W
         M+6azmn/5uO0wgHSvkHASjlizDbtXJyEncy1OCDxGD7iCTYtAzKFZRbzkdmqHAbaHCqp
         Iwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753457373; x=1754062173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rfV+Zm+Mb8q0Xqs52mwlGZV13ETEQ7K4+Cj/aArnfPE=;
        b=LqViXaO/mh1XIql4FJ1eb2hn4utNqUiZBmDy24u02/95h1nUfWIvPqLFYxBBwaAE33
         lS99C76pyV8qVSrZJPbSjy7i1UfvBr4jRCutoW4eaCBsx17nQkUiUgWuPK1k2id7W6hX
         l08fuJGIGSF00PJjKXoaaX9DhDnrFS8jVtA1m7MVA5cQA4st2884ZyQj0FjYDGKdxmIe
         b68nP/gCTYfHLc5kGLQS+wmVuWc8xkjnsKetjueynuzosmFVwCFM4o758lWPXKm7GbvS
         ARe7TQ5m3UZUiyJzhqz2yaasU9pZq9p1+Md5/LkINJGmxA6tkNuyTohLvy3aXs2xljN9
         zHgA==
X-Forwarded-Encrypted: i=1; AJvYcCXU110Uimg8gfK0pSS8Gou+x3pEWyiYl4F9zD/LvohtHtQZBjYwxcU9Acypsw0rc+/F8nJ5VZgNb7ghly8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMgpPR0evtl7kirxwzIieGrlj0CfQw5UKrbCmI+nOo3HyfPwLp
	SAsoBmS4f9gNr6sC8f3yNcNoFSkWGyZexSZbQhrGAELB2F6jeKK7Jf1o
X-Gm-Gg: ASbGncuwnxp0tV45hk3lY2pLjTb83rscSvU+sInrEQY2IWmJXSYse5NnoSlQ9iJIDEC
	+2WlrEiWPJrJk4vgTFih93M+FA7bvL1hlGi0GqSyCbVlqm9YBgH7IG1AFfQPDTEVMHvSYVxlRPo
	GRUjuPrs2vFZH8DZjTGQjpJnYWCjR9YXFWChKywNqdMJko1oXhgEVoZbSq9Qc+ZOFSQUDJIhmwl
	yvcpjKubT9yBBE3nIz1FlOc3g6Jy8iu5Q5/1O50kqgIRGav+4hUHJfT0BUROifHzOaXLx14mLyO
	ScIYjPiiweUpjNqAY0P9/ep7pdlpyr4QHV5fSg+RrEt5H/Xw8vQ0DJOCOVKUjMyuSYjRScPZBeX
	utkPXXyfKWm6NLK9CXj143f68UWd9mKCeQmEhDpV2R9tFN360KQ6K5XK75tmWTRk8
X-Google-Smtp-Source: AGHT+IHsADjr/7n20DNI6HUaaxtRPfkv9NNc665R6PQ8xea75aGVOhMeWslJh/LzdE2cqODvVaKp+A==
X-Received: by 2002:a05:6000:2912:b0:3b5:e07f:9442 with SMTP id ffacd0b85a97d-3b77135efaamr5340885f8f.19.1753457373359;
        Fri, 25 Jul 2025 08:29:33 -0700 (PDT)
Received: from yuri-laptop.sca.unipi.it (opnsense-fib.sca.unipi.it. [131.114.30.34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778eba85asm198016f8f.29.2025.07.25.08.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 08:29:33 -0700 (PDT)
From: Yuri Andriaccio <yurand2000@gmail.com>
To: matteo.martelli@codethink.co.uk
Cc: bsegall@google.com,
	dietmar.eggemann@arm.com,
	juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	luca.abeni@santannapisa.it,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	yuri.andriaccio@santannapisa.it
Subject: Re: [PATCH] sched/deadline: Remove fair-servers from real-time task's bandwidth accounting
Date: Fri, 25 Jul 2025 17:28:04 +0200
Message-ID: <20250725152804.14224-1-yurand2000@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <86013fcc38e582ab89b9b7e4864cc1bd@codethink.co.uk>
References: <86013fcc38e582ab89b9b7e4864cc1bd@codethink.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Thank you very much for your testing, I'm very glad to know that the patch works
as intended.

At first glance, I think the warnings you are having are related to this bug
report that I posted a few days ago:
https://lore.kernel.org/all/20250718113848.193139-1-yurand2000@gmail.com/

Juri Lelli checked it out and made a patch that addresses these warns here:
https://lore.kernel.org/all/20250721-upstream-fix-dlserver-lessaggressive-b4-v1-1-4ebc10c87e40@redhat.com/

Have you already applied Juri's patch together with mine? If not, I think it
should solve those issues you mentioned.

Have a nice day,
Yuri

