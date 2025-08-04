Return-Path: <linux-kernel+bounces-755546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8F7B1A837
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 18:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A9B018A4759
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8A428AAFF;
	Mon,  4 Aug 2025 16:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="vTa92roP"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636FE28AAE0
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 16:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754326456; cv=none; b=nGyM0kg8ISBgH6v5m8yfu1OhnzM8X59sNhJI8kkUnWO7oa4JJPySuGewNntklrDhWaVSSP9lo1K62x5kpVMRHBoyNVtYGfj+XJrKtjh//7QWXNDshEq76pxQ7k9lXyOH4dvAFPeMlfGMfquJI/cqSMzZ4W2uKReeUjPGj3BEoX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754326456; c=relaxed/simple;
	bh=RJQzgzVZ9sfL06y59Z8cjqtnnLIQ3KwQk8KSi2+egV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DL06O3Y3BrnIdOupNiyAocd8166j1iEHbAKlBJJmA+jQMq1IanxlNXd//G+VWHSNaymlg0dduJ8rpKaHvQE752NBTNRfuPIEKaPgp45XogaM8yWodWkLzme8e6n2LQa/T5yxWNXkVysZHzMFmN1yPS36w1vAurHhrcVQwwDZqNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=vTa92roP; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7e32c9577ddso272244585a.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 09:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1754326453; x=1754931253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RJQzgzVZ9sfL06y59Z8cjqtnnLIQ3KwQk8KSi2+egV0=;
        b=vTa92roPWu3t7lR56Wl0e/rQVO0WjOWCrEc7w1J2rUIAPA15y8ETq+DMYAaGEs0w+t
         RdezFKclyNwZXOIXS/YATRDy49JSr8g3zI4IqDtvkPg1sQm4GYEZkL/Gs5+aqdLeEFP3
         jSVrEbp6shbwKBcA2J4U/pz5blr1y9VhzOLb7ZzicNdfq1SZJ7AGS35iojcxse/DXyo3
         NWNuRw4lavQpvP1ooDjYXZfJdwnEU+YZfyx65YTpR6HY/hEanLPVibDU3439d/I4PuvS
         ie5P7POpGDn3y7NBdR00DGfAMw7AjY9BU0Qs8rB5/q9m1JwHPTp5dE8EpOtMd0VrU0cn
         aoLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754326453; x=1754931253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJQzgzVZ9sfL06y59Z8cjqtnnLIQ3KwQk8KSi2+egV0=;
        b=buSgaM06iobTA02QhtbKEHLP8JbZWLP0Ohx+qxBhmmjezQzmjZZgLkCAnYxtvRRyU4
         fCFnNTtsLbaC/KvdahkhfQBu7nDNzu2ekO9lB+OjLLU+MaX8tW3yGc8do0eAnaXtBZRD
         h9feZt/WkJ1/8vGTWegfiiDBNZGM7PW6rUq0FLmT+4t0hkhZukuMkbqujbst/oI2/Rml
         q8wzPIm1vZuj5EOb+NXOOtW6ivSlUIXNWpECy1+v4iwBht5dqmU/sj0L3rAWDTxmGGKT
         8BNcbY20M024frc8MSnpP4h8ag5XyLIIXgFeRBMcdbwEzPAUWUm6N8LigdrNMAgLMa4I
         KWtQ==
X-Gm-Message-State: AOJu0Yw8PdxXwD8Wki34VElWMk3Ltp0E6BKPnplCgNVVVKKYyh031o9l
	EMvPxhkijl6kvOD3uFWOPvtqgdhIlbk61QbQBPWm3+xhnxqfspM+3ldi34c9TGESTn59kz2l0+J
	PY41x
X-Gm-Gg: ASbGncuSFlOvwuKiWPB4a80d3tbASi90pRasFlXdrdYlAnI/g16Pw/03aemQHuypYyT
	s55+FOtWq/4mtNtqVz3ZYG0FozQWavGPCs2g4Whyn1lFBmAROcuKlTMtq3PNLE5eqHN365TUloV
	JcNi2L0T8Do4O2pGVE/d5HOTdOj//pBuwLEFpN5WmB1+/ROShS6kHsj+pKN7IBeUEIehfyCcML4
	5O1fsWapzkLPWYlyHtl08HdTxb9s569KuhLaMuZpaxbHutp75gN5NuSm8gfvwh6Bs+wmUsJnruL
	Kc78s6o89eS02cOZD4+9WIQdQU/7QzOOKOqV87LkocqpVtclYQiVqIF+uto42WHYD7lfGxjrzVJ
	yNY8+rISA17zGrglRBAaghg==
X-Google-Smtp-Source: AGHT+IEvwQQo0DtQbm/3RHBFvHstOPE43gzFFtVI+ZE4T2j6bzMLuHT3WUOzF7nHRzWlYq+Hof2k8w==
X-Received: by 2002:a05:620a:408a:b0:7e6:3153:e9d7 with SMTP id af79cd13be357-7e696267b98mr1382150085a.6.1754326453037;
        Mon, 04 Aug 2025 09:54:13 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e67f5c30ffsm568655785a.33.2025.08.04.09.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 09:54:12 -0700 (PDT)
Date: Mon, 4 Aug 2025 12:54:08 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Chris Bainbridge <chris.bainbridge@gmail.com>
Cc: linux-kernel@vger.kernel.org, surenb@google.com, bsegall@google.com,
	dietmar.eggemann@arm.com, mingo@redhat.com, juri.lelli@redhat.com,
	mgorman@suse.de, peterz@infradead.org, rostedt@goodmis.org,
	vschneid@redhat.com, vincent.guittot@linaro.org,
	regressions@lists.linux.dev
Subject: Re: [REGRESSION] intermittent psi_avgs_work soft lockup
Message-ID: <20250804165408.GB1303466@cmpxchg.org>
References: <aI_fUhpBrIBrJ073@debian.local>
 <20250804133240.GA1303466@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804133240.GA1303466@cmpxchg.org>

On Mon, Aug 04, 2025 at 09:32:45AM -0400, Johannes Weiner wrote:
> We probably want Cc: stable on this patch now that 6.16 is released.

Nevermind, this didn't go into v6.16. The v6.16-rc6 tags made it look
like it did.

