Return-Path: <linux-kernel+bounces-871500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8751CC0D765
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AEFBA4F3054
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D695283FEF;
	Mon, 27 Oct 2025 12:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZ9RCs5Q"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635B185C4A
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761567443; cv=none; b=UKZ6LTCgsGM6JS1T26qf52cpSAEJK1P5Z4r0oLklQl65/pHZIFCrhMFNkR/C5Xjrjy1BSPJuQfXUNmYTnvhvim+V9whjC8YFtmzdVrMzlcqMomZzjfWlxkPqltv/0rgyG7QzbobKGOYsCN8mv/mUTtseIZc22ViYLzY64Y/Aux4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761567443; c=relaxed/simple;
	bh=zTMqqkMnO6DYfa7+wlhQspHetXrQiIjWiWLP7Cp/77Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SkPtxr1ZaZAnYklbxn+lbxlB7xC7HRxux/3nPcRc3IKXpQ3RTnk6lBDfeeEX9pG6Tu5S2xFtk0cE8QcTqE5Ooa+PDLZ3/7NlEc3iO0DdoF+YGVq3RUIJMnK/PIeDhZu7+7n6+xnNx4FHt6zv+I12WTNY7Wd3s7oKzSNS2Qj2Tvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZ9RCs5Q; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-784966ad073so55806057b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761567440; x=1762172240; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zTMqqkMnO6DYfa7+wlhQspHetXrQiIjWiWLP7Cp/77Q=;
        b=WZ9RCs5Qt+a2aYZUu+UE8JurrQufCKpdwmojMEppxFT37macorShKneIMshJg7RWsn
         qZ2cgMleJePXQ+dtET5nboXuXIapHX3fFD622KdIV+/cKjZ/GkzzW/hkQGBCS1+hXx7D
         s8IvmvMfkSl78oCh+DSJrtkSvsP1zcL4KyevPlsA5tZXCUv9173VgBWTShi3rVpwltWr
         iWKC99SNMXKPekzxFK+b3wn/zrfe20sO1GIcSGSC066nucEvjWeCQn+EI87ktFx7Y/Vc
         sGtf8Ij6FQlHhHP+9S7UqzshUhoMQ7/dbuFvtCuoLZklXtj/SJANBgB0wc8dHp7Ba4Mo
         DYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761567440; x=1762172240;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zTMqqkMnO6DYfa7+wlhQspHetXrQiIjWiWLP7Cp/77Q=;
        b=P9nXPLuDHtePGl8WtoUmWI+BBLjpvv9EYmAW6fYpqP261vUs8LgTv/5K5S7QI0g0aG
         q8b8nZJ3uu/D/6vhJZx3kjwEyC48ABWr8KmuAw3hf2tv+fATyPLXVuaZsJdJsWSGu+Rn
         3f0Bl66M4D9/HxZmctLyQY2jNbvykHXLw3DYi1mSfkjdUT5cs50SR10hwh0jTXyFIisv
         J1mODagV4O8X77J+a2uPhaAXbXN30rO9AqcU1MY6KzPvrbOIS4N4ZndIm2BrOlNp7CMo
         ycYopqfr5dgxlRCB1GpfTmm2ueyIkl5Y99151jlEZYaHrq+95fHEVMEyXpI5/nu3Jph6
         JNpw==
X-Forwarded-Encrypted: i=1; AJvYcCUBsVyr9uX/N57CB2Yb2jYvZWkVHzag92gkjIj1GNF9kOuG/ZoTggBIHk0ubgzUdZ+5+uOeWEfqYZuWzWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj6ccthxnbC4DsDTcWZB4qAz5401ldQh/kihEPe6d8Fq2+184Z
	j9wMYe7NgZ/wK2qhiYXtEDt4tQRhHOxBqjHWiLmdgCVwBhhGPIbx1YyMhemQVUHWInsfUFDCH5x
	QaByLNLa0moBconnXFBQioz4Yo5yjnmI=
X-Gm-Gg: ASbGncsqH6RTwV0X7fpcjub6/Tr+9Mbz/MuiBiI+0Jy2hpiNSE/6GHGfjSTbTZBlE8W
	5wP6JJ7nq8DJEDMBKOHuT6A5oEaDjOArQ3S/qKRW4sbM8ubGFs4UWwalST0jBSPYDT5OGN1S9j+
	Mj214+gMQv/hS9ct5Cl6G2Kej7z7DKGexQKQJfm/unCHGn/xsjNduoyDK6dx7g4kk0ijR45O3pj
	y6s/g6YGqf1T3QmIVRXHoUekdAdiRXabvY84xSRVhqOitb07989iXWo4QyGG46gUyiAJV2DTCTq
	5ru3pRdTgBzjgIGYVT5uDg64Vl0=
X-Google-Smtp-Source: AGHT+IG0kzSdAtGvyFWMugmV7li0vGK3UizGnZGsojmO3U5HNvI62Ga88zD88oT5E4T6A7CSPsvXRUtXprI/QpkXSt8=
X-Received: by 2002:a05:690e:d4c:b0:63f:2b0c:2d61 with SMTP id
 956f58d0204a3-63f2b0c2eabmr14253696d50.60.1761567440143; Mon, 27 Oct 2025
 05:17:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022233349.102728-1-kartikey406@gmail.com> <a6dc6438-7aaa-4c21-8df7-ecd618b826ea@kernel.org>
In-Reply-To: <a6dc6438-7aaa-4c21-8df7-ecd618b826ea@kernel.org>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Mon, 27 Oct 2025 17:47:07 +0530
X-Gm-Features: AWmQ_bn8933_qT8pmIytRPY1lqL6cDkWjTmzyPJlqvt8RXmy9dnm-zFuOUT2Yw8
Message-ID: <CADhLXY5RomCGo_xyBuWdRPP=qgudkdcxoSRd7xp09M0vGTBVNA@mail.gmail.com>
Subject: Re: [PATCH] f2fs: invalidate dentry cache on failed whiteout creation
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, 
	syzbot+632cf32276a9a564188d@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Chao,

Thank you for reviewing the patch . I will send patch v2 shortly.

Thanks

Deepanshu

