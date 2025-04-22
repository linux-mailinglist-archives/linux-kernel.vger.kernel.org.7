Return-Path: <linux-kernel+bounces-613476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66691A95D0C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 06:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 442563B5268
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 04:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592E41A3162;
	Tue, 22 Apr 2025 04:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eAJWYuRO"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8384C8828
	for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 04:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745296900; cv=none; b=jByhaTaCIddV7YM9paAwfjIH33m1QllEXhZ/EyySAblxxN2JsUjM+6uFCMRugCxPn+dw226krfAPZ8FpnVgS998mxm/0eMErUdVZ3aJ6dZIOC9MZvhxFzoyrI6Yqspm5L9J2XhTiRgg0E9iZ1KEzrfWS0ODl/mAonm4YWrIhv1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745296900; c=relaxed/simple;
	bh=am72mtWch1l3KVKLLgauCChlPFmJo0q7YZvvZg0tft0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oUX93tmSfRmj5dm6DdOVMa53o6EtNDO1CfXyn4UFDyzSOJTuav8+WSAU9WQ8Igw1kqw4VrPw0Z3DqAtOcklYr7Qp12G2Rd5mYwPQCQCI+9yNHybK7R2hBKCxbtQg3fLHXgYGpZGGss2A8MEUi40KA5TSfuRfQPxVPQ/fYrUcv/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eAJWYuRO; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Forwarded-Encrypted: i=1; AJvYcCUAietndecHkkFE676MiIzPo3aVbO78TMiU9xZwZUbhOT8e/VcPrr0oJBWVJsFkEBHT/7Yj0Y8GWhdjd8D6@vger.kernel.org, AJvYcCX8e5lkx6emTA2borfuxb5jC1soxyqyvHudZ1hZb9i78v2n3OgGniTV9Xu9a1N52ajYNtNDlsa9@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745296886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=am72mtWch1l3KVKLLgauCChlPFmJo0q7YZvvZg0tft0=;
	b=eAJWYuROTknq15uX62IPRJfArBDSJtUKvJkHYF2BM4uZsj4DCiLu95gGSBLrVkGKT1Q1VE
	JpTmIdY0+NXXf0T55BqaTvCfknB4xMGUOO2HBcleuPIxKOUuQBLSrPvnt2AZJhMFSk3Nxd
	ycsCkhlmqPWcbzU1yJj+zDuOlChCGzk=
X-Gm-Message-State: AOJu0YzciYEDxeZHrA/8xzi/f+E0+XPr7I9sltII7tW3DBWRFovEecDt
	/hO5jmsuyg1tadMs94T+Pcr81AeYZwkCsjeGavdpoA6NSiVju9ZhLDCQxlxy32OitvXkEivdUTx
	Wz8hFLMNidmN2eTbg3c7/gOvR4hA=
X-Google-Smtp-Source: AGHT+IEdtQUfZg9Nes25b1hvoET1MRak22sBTMYY44ZfX7B3F3+hxwiGJ7WVADpUZPirqQ+YnH3B+eKzeHX7EVmP3yI=
X-Received: by 2002:a05:6102:468e:b0:4bb:dfd8:4195 with SMTP id
 ada2fe7eead31-4cb81b60b49mr9621804137.3.1745296883958; Mon, 21 Apr 2025
 21:41:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422012616.1883287-3-gourry@gourry.net> <20250422043055.1932434-1-gourry@gourry.net>
In-Reply-To: <20250422043055.1932434-1-gourry@gourry.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
Date: Mon, 21 Apr 2025 21:41:13 -0700
X-Gmail-Original-Message-ID: <CAGj-7pXC0fDLWsuUh7PLNSyzCv-4LqKoOfE=hizUeOfoJqQ7Ag@mail.gmail.com>
X-Gm-Features: ATxdqUHGnbKtYzS7_6xMY77prDcfzTNXx7RPZ1T_ZR4If9HzihBdR3-O4dlMnlA
Message-ID: <CAGj-7pXC0fDLWsuUh7PLNSyzCv-4LqKoOfE=hizUeOfoJqQ7Ag@mail.gmail.com>
Subject: Re: [PATCH] cpuset: relax locking on cpuset_node_allowed
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, longman@redhat.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	tj@kernel.org, mkoutny@suse.com, akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Mon, Apr 21, 2025 at 9:30=E2=80=AFPM Gregory Price <gourry@gourry.net> w=
rote:
>
> The cgroup_get_e_css reference protects the css->effective_mems, and
> calls of this interface would be subject to the same race conditions
> associated with a non-atomic access to cs->effective_mems.
>
> So while this interface cannot make strong guarantees of correctness,
> it can therefore avoid taking a global or rcu_read_lock for performance.
>
> Drop the rcu_read_lock from cpuset_node_allowed.
>
> Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
> Suggested-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

