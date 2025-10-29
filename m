Return-Path: <linux-kernel+bounces-876744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DE525C1C36F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BAB184E3049
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35FD32BF3D;
	Wed, 29 Oct 2025 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcmJ5dwB"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54D52F0676
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761755825; cv=none; b=ufA16fRqjTecfRNa6Zdy1zxT0sq1t7TBQBCloE9arNQsU8VPeGUrAetTd+Oct+IiOQWU/OhMsQ+I+fmHBrBpCiXWezjfwa9ca4JRGVDwGH+VAXH187jy+FwI7EcUNx46XIMcq5K52EYh16bhWxX2qMi7lv1YVtCCJ6Y3oQ6ahOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761755825; c=relaxed/simple;
	bh=qGMlqEZjKYp5S+5IieVYbFA6n2E0dxbgiRC2sMcci1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HDaAMGa0zLXfcpeAtpUX216kTcmjuw9mfnRJc/NuvcRhqkEnKyt9gDlf8BlrAAs/gK9qyRfiDkUODkdPIdfGE3hfUwP6waRO2/+U2nrRiqmdpf49oQid7so+XKEAZAH4banduh44p+EhlBY+81Ey0LHcV96q1z7x/98VfIl+pxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcmJ5dwB; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-73b4e3d0756so1318437b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761755821; x=1762360621; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qGMlqEZjKYp5S+5IieVYbFA6n2E0dxbgiRC2sMcci1I=;
        b=IcmJ5dwBljfAbku9z8+EYAfgmt5ThOFmzlk8Ym7oj+zGpPjtkwo4QXP+zbxpIADvfX
         SXkq5RyLDS+ariftQka46gRxFG1MYxVu9GegQlIHiQdDCt6tE9CVcuQ78Ai3E2qbIpMX
         n9iqLByaXHhcmd1JYt0IzFbWFJPjf7h7bAvBje7owGKP6e75bhmYp623dA8HB37L9oUO
         Ql5C04r3eI9Q00CXRlgsxeRJ/NB37ldphMuc53/383BDjB0aA9eGuHVkWPw5rQozZwgT
         mUphpLZsUIlKhc4GTIQ0DY3hKEKQSZBRR18ZGuRqH5gtWzBXn96BoHzRtOA1Ca7cLZvx
         0sDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761755821; x=1762360621;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qGMlqEZjKYp5S+5IieVYbFA6n2E0dxbgiRC2sMcci1I=;
        b=m2ULddeWA56dKjSVC35YrRuhFWXsVpqIds9eVLN7JLX3fwmIJi7dXjrGiODhpmporG
         ZK2Ak0oHao5+u56FEUztghRXnZvz16e6UcT33jzLaPSStcnLnQmNh1qQSPgN+Jh2xe1N
         J2KcWOBBhKnvE4GIwSxvEIwPtz6yz7wK7Pn3H2nE/71rXu1XN5BLoHQTJ77gg9Rk3Th1
         QSWS13uiJ6tcnW/wVAxXqJgBzy7aRgAYXypl6GbL1CQ9u9g+tNPGfuxvSluj100JxxTb
         BFPyQEt+qw1eAqjDHjI83mW8GbSr4DHfPoiuTtjYkW9GiJQioMq6uEd8Z6Ulw4NrPo3v
         0I1w==
X-Forwarded-Encrypted: i=1; AJvYcCUav5YiyFSyulDoOcrXeRTEjIhDnDF3Zh09NSllyY4XkjkRXK6j/3Mj+r/xZ51jwNmkeoLHZJ1/d1u03bI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfck8QF8YvgUhMTNmN9/o2KvnSVLOKpjOT/my7TezcNYznS57W
	4fecI6X8JnBluYnSMThuUwllRwCbnQ1dOkDtY8a5CYjlO2bRFvJbgag90BDbapaBDPqR9Mv1SNI
	EZscb42awOMUOe34WwLXBlcadkT1YYs8=
X-Gm-Gg: ASbGncsiTk/HwrGHjmYOYB5xzRS+NRXYFhOR/tuYh1m0Io62ST2J0Y/LLYJNOEpwXWz
	G3KhbihaqLIypYi+JNcr1QILsPSgX8zfunswjjm20fM43EVGvIMnInyTvyD0TNGz8dgQQdwXbiH
	AKyKCRwF7wuS34qsHgrLPuaoZEup8aYwBBXVLjHZgsKRvy+G5OhvHbhsU9g3DuGBhGV7NjjYpzS
	MjtEZncjZZ2GjUgiEJRe9WXcKpYihls/GHgBItGHBHCKjnw4o6BZNG3P4wQjg==
X-Google-Smtp-Source: AGHT+IEEhdrnhAIGKxvabw/x0BOPfVjo214oM41Opns7baxmqAdYDdZWpcyM0kWOnxNmncxTiuZVHnVa6tugnIs2HJg=
X-Received: by 2002:a05:690c:9a8f:b0:783:afee:fc46 with SMTP id
 00721157ae682-78628f8eff5mr31278617b3.37.1761755821463; Wed, 29 Oct 2025
 09:37:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABPRKS9GGS2mQ46UMmM3G_NnamCsYj7zBaa_c4rQfO1h=59wrQ@mail.gmail.com>
 <dc6288f0-989c-4314-9217-8f1a12eb206c@flourine.local>
In-Reply-To: <dc6288f0-989c-4314-9217-8f1a12eb206c@flourine.local>
From: Justin Tee <justintee8345@gmail.com>
Date: Wed, 29 Oct 2025 09:36:32 -0700
X-Gm-Features: AWmQ_bkYqCwqgTXJV-73FmW6iGOzC9mLFMAx4nn5hm9_kYOzj8oWovAhwrKAM3Y
Message-ID: <CABPRKS-xgumM-E8hKO-3SoOg9xP-ar=mB=jgZFwsG2T2VqE99g@mail.gmail.com>
Subject: Re: [PATCH 1/5] nvme-fc: don't hold rport lock when putting ctrl
To: Daniel Wagner <dwagner@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-nvme@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, 
	Justin Tee <justin.tee@broadcom.com>
Content-Type: text/plain; charset="UTF-8"

Hi Daniel,

> Should I add your change to my patch (obviously mentioning it)
Sure, this sounds fine to me.

Thanks,
Justin

