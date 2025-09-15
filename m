Return-Path: <linux-kernel+bounces-817481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D069B582AE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E13651896CE5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118DD2749D9;
	Mon, 15 Sep 2025 17:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b2GrD+fc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B481721FF25
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 17:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757955775; cv=none; b=s/Zz5D4shzs2DaRedUaWKZsnYM6cfISXGO9H1AgRTy1g8oR7XhaIifEHHKSi8oPwPU5hYLfQbFKgioz0E5TJFyz6lzCdXneNWMxkk0AbZia6LWNuEHzT6vTZeRmsafKxDuyBf9yCOxs4+cauqftCG95cGgfN+v9TNqcTwP0TBqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757955775; c=relaxed/simple;
	bh=66S6aJAt8GwaCeyJEzfuJUAXw7t8Zv0VaPOn+Swd+mw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=nce+nbQyEurNNjwaeU6swKU/Z4I910F9ys5VUp+c+epzaSV790goMO3vg8DccxMwHMb1QZSiz7JPD0VbCO5ky92zW0EGCBL8jmkpWtbofu8JSXdFTJ85TTZ2cWWtBqlqKVBB8oZba5WT2yBucKZfLyZjMGQViTKabbN42S0rpyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b2GrD+fc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757955772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=66S6aJAt8GwaCeyJEzfuJUAXw7t8Zv0VaPOn+Swd+mw=;
	b=b2GrD+fcliKI6W1NVZhKhpGAXgp6CvXf+ozN8zC1qz9JJ3VFWZU1vIhuC0DGZP2efOQYRC
	27LH5vWkmLX4P+ooamZ7lPyIRq/TiOdvUaR0WAqJ0BJQjR0gp9ZbgKl0fevErEZl2TcVTw
	5YWIi8dwuX/0NlMkaQw5mQfJJeeNo84=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-r7xI6zeCNFO-NhEzGq3P1w-1; Mon, 15 Sep 2025 13:02:51 -0400
X-MC-Unique: r7xI6zeCNFO-NhEzGq3P1w-1
X-Mimecast-MFC-AGG-ID: r7xI6zeCNFO-NhEzGq3P1w_1757955770
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-62818e23020so5102598a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:02:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757955770; x=1758560570;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=66S6aJAt8GwaCeyJEzfuJUAXw7t8Zv0VaPOn+Swd+mw=;
        b=QRJgAtzp/ZV/koiwijB9D3FLN6P52ChwsXe5rdEZAX3qogGmKqOXAMMEkekTbrRM5X
         QRJLo6GZKNT/uiuRAfVEyPFHeLD73MdtMgtnxLcW83InJLpmGzKG8+AapLHWfhnw4Lom
         k2/+vqRPcMerD9KtroEQwtWijhHruFYheYJnPvxST07IHFCeRUzAe4o7P+Z+yUkqgA3m
         vkaE577y3zjsSwGLkfvWG8S2h1jjf6+avziRcNZuBk2J5r8kHB+siquFuSBOWCxS8mJn
         q2oJh716+hwabUxrvU8JzPShP2o/gMt76rYRAq8DcZh2k97jIlkabXb3tzMsvJDjskGk
         j/FA==
X-Gm-Message-State: AOJu0Yz0iogXOatPCTa2c1myStWDrVQHlu3vdjBly8OxamQ4cuctAnz+
	2x90+lyzbbWun5BEdjFfKiYL1y9u9vju0HQ4CsFmFkXUC5AI3LuHCMeARO3REVKJxUIwLfmBdE7
	yt6V+FqLVCsMWrihwWOis5Xdp6uaNZb0BiiuSuB1rZOaUOffr5TFs9LEdTKAHrOR7iA==
X-Gm-Gg: ASbGncuTM8MQiZG3OljveHGRo8Quh0zltuRgjRtYKIiqJs+WY0lJ8YdiqRzXJSWZIEs
	YkNxFHEoztxc7BXm89v9gY/XVJ1qecIpp+agnIXXoKI3IYCh9qwHqLi2t7AfDrAIzvxkSo0T1+9
	Sk4MQ9vpO2XP/+a/wbQlY946ic7BRmakPNrgOV9YtGol7gfPedWucjeKF4DqYmpExbdMfvQeclo
	xKpalCSAAw9F4f88DfMrEBeaHzzTcNBoLwWvkTwe4OUFBQqP5vd+f8u2G2lrrJowBfViXFsSDwg
	Bbxw8OPzs2JINFNZoj4y+ciIan7gv5mAcHy3
X-Received: by 2002:a05:6402:2382:b0:627:f3b4:c01a with SMTP id 4fb4d7f45d1cf-62ed82c664bmr12319305a12.17.1757955769794;
        Mon, 15 Sep 2025 10:02:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIswFFmwmYiiMkSoSeFQe0/+FqLFUPp7yOhNqZzot9BBCzEIVswtcmc4mppMGvtJK7CLecyw==
X-Received: by 2002:a05:6402:2382:b0:627:f3b4:c01a with SMTP id 4fb4d7f45d1cf-62ed82c664bmr12319288a12.17.1757955769448;
        Mon, 15 Sep 2025 10:02:49 -0700 (PDT)
Received: from [127.0.0.1] ([195.174.132.10])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62ec33ad2d6sm9597287a12.18.2025.09.15.10.02.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 10:02:49 -0700 (PDT)
Date: Mon, 15 Sep 2025 17:02:45 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org
Message-ID: <820443ea-56d7-4fd0-9535-b1339e53240c@redhat.com>
In-Reply-To: <aMg5EzmxG3hG7aJK@yury>
References: <20250915145920.140180-11-gmonaco@redhat.com> <20250915145920.140180-19-gmonaco@redhat.com> <aMg5EzmxG3hG7aJK@yury>
Subject: Re: [PATCH v12 8/9] cpumask: Add initialiser CPUMASK_NULL to use
 cleanup helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <820443ea-56d7-4fd0-9535-b1339e53240c@redhat.com>

2025-09-15T16:04:53Z Yury Norov <yury.norov@gmail.com>:
> So why don't you pick the original patch instead?

In my opinion, the /juice/ of that patch was included with [1], here I'm just adding part of it.
If you prefer I can pick that patch and adapt the commit message to reflect only the part included here.

[1] - https://lore.kernel.org/lkml/1706509267-17754-3-git-send-email-schakrabarti@linux.microsoft.com/


