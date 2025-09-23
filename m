Return-Path: <linux-kernel+bounces-828239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EE5B943B0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 06:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 438924E18AF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 04:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488862727EB;
	Tue, 23 Sep 2025 04:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxEb4Ssk"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E471482F2
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 04:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758601732; cv=none; b=RByg7nQR4WLRSg65PF3xh6pWWnrB0fKCAgD+v5uU4KMaoeifGkcFqEz/Ow38y2IyOGymouuI3ymaD4ADsJOZdxivjOuTyRVYOwS2iM1AxyGB48B8mcmDVQVptLb7/EGK5va0UPk/QxO+wi7TOWPj59pL/J4L/l0s5YxWcpdRB/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758601732; c=relaxed/simple;
	bh=HEUcC0Yq7SL3HnYczepYlqBDp9hawlDL2Z9p5vapRWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RhkhXAsphlhDDuCY9B1JW922t5BSyhdGfXG/tV+9Zz8xFQ01KuHfP3LNK/o3x/Cx4yNbzxoHRS70tN7ruRQJ0a7JqjjpPBJjM+ohOO1A01YeesV/BAa4fIszpYIAwQrNvLLbQAQzRRVUPVvUeQjdBNM3MnaQpTRmLrglcxlvkn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxEb4Ssk; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-62fce8b75a3so6254038a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 21:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758601729; x=1759206529; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t0L8/Mj/CMf/BboL9XZ5gn7LsUamResi9L+Dypyqa7g=;
        b=bxEb4SskWjdLvb3nSCcWZB4i0iSS2qrFg7EJ6+QnqLepAa8oCjlf+yCG1zCZy7KEca
         7gMzE6lPMZuYPpHNGsUD+RJ2nsycnAZGxHT5b5r0WUfDWwepl8peyQ4lSBml+U4PgZzS
         XGCYi4AmLYeyrmHLOJOGG59XRkFTM/Suwbt24DoIjgkWn6rASuX77XsyKTcMc9D6WkUQ
         YINtWp6/3Zc+pscH5zq39DiVeVoKJNhZZ3do6s14oZdsD15TWkziXh8vFaYap3c8uSNL
         ly/SOLO5F8TLFxpbVXHeU6BmEHhn5cgeSSYEUVmS2HXFhEC18jIbgVTLejrRVLCjEbrQ
         6DNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758601729; x=1759206529;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t0L8/Mj/CMf/BboL9XZ5gn7LsUamResi9L+Dypyqa7g=;
        b=Zns7HOLBg32zjuWanWakDNNw3uNXutHVysTKg5BCfRKckwZmup3tpD+wpMcVuEjmLb
         t+0R5gOJ3gG0Gv7p00zU4MOpArMefBrwgW1xk57iPfb3FXiAWa2DeatKdf7jVlEFx9yR
         EMVSrNXa7Hip9CLvpzhAen3Kw/QUFFhM9/57V7M6Dqk5YhklyVHQ0LC6dC0K5/szEjL0
         fK//lS2cL+LScNJtKWHrmnoPET7TrNpw8HoA9WhcQ9aJi48YeLG/xSM3gin4wleNOJBE
         qfBSrunwcOavFeoStj3GSXH6T28PAJd75VxMtDQMY9ZHfRy9Fttv5Hy4C8S4hkWmdLK2
         aJnw==
X-Forwarded-Encrypted: i=1; AJvYcCXxpOC3jfiOIYo3BF1iXni3YgZel/5WRPqkBJly1rrYW9wwKccwxSYpyzwAd0Hhhs+CM7PNlR902KynPZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YydzKz1Z3/rFz8sytLe/i0+wxMbFv5n3vHCU0iNPB3S+CneWzGb
	B8LL9es6o2upv/iRXqjKH2Wc2jMUGgL0TreahrUXgzrjq/AAK5+PJmSlsdXo5j8vcmIh11RCCLm
	L7aTc4ruErPT3McPqOdrhExyk+af7P6k=
X-Gm-Gg: ASbGncuRA9B/EDKOsAnZXoCDfqL9eE8KqWuRWuKYO6fC1/pJFI/K99APUNIpGX/sqNW
	Lu2uZKgUPm+Ybp+Z8IlES5cCLaSfV6sjsD9tAl6KexjzLlWp8hhvk4L9J4OlzaZc2zb9MKA2bey
	rvXWBxXCSAGC0qtZwSeC0rd08DJmWgpJCHU3IxBO4zrGsmKda07BHW6qW9Ksd5B390s1Ke09nCa
	FRnYT8q/YavhPkjJDZ6NJOqETXP4odKrWHQExEdatvYnhmc0eXwmg==
X-Google-Smtp-Source: AGHT+IGI8VvJxjrSqdRzk45M8/kjiV8JUO8fNyOSSFYDwY0MLzTPEqc24EHBbra4TdMiT9VAbUvHKiQhHatek4cxEcY=
X-Received: by 2002:a05:6402:90a:b0:632:9d0f:dc6a with SMTP id
 4fb4d7f45d1cf-634677e7c45mr842619a12.17.1758601729233; Mon, 22 Sep 2025
 21:28:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922170357.148588-1-viswanathiyyappan@gmail.com> <aNHBUJxAs-vomIF3@casper.infradead.org>
In-Reply-To: <aNHBUJxAs-vomIF3@casper.infradead.org>
From: viswanath <viswanathiyyappan@gmail.com>
Date: Tue, 23 Sep 2025 09:58:36 +0530
X-Gm-Features: AS18NWBRX3q1A98kbmNFmK2Q0aBW6YNTfnGsD2smO2bt-RtTaenmbYqnzoT0BHs
Message-ID: <CAPrAcgOsYofEUxOB81zaJb0vo994N4diDzYYTaZ-hGEtke+dyQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/slab: Add size validation in kmalloc_array_* functions
To: Matthew Wilcox <willy@infradead.org>
Cc: vbabka@suse.cz, akpm@linux-foundation.org, cl@gentwo.org, 
	rientjes@google.com, roman.gushchin@linux.dev, harry.yoo@oracle.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	david.hunter.linux@gmail.com, linux-kernel-mentees@lists.linux.dev, 
	syzbot+94d20db923b9f51be0df@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Sept 2025 at 03:06, Matthew Wilcox <willy@infradead.org> wrote:
> Is it really a good idea to support 2^28 vclocks?  Surely there's a
> limit that makes sense to the PTP driver.

I think I will add a new macro for the limit and validate against that

Thanks
Viswanath

