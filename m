Return-Path: <linux-kernel+bounces-805895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1A5B48EDB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06DD01886C07
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F87730ACF1;
	Mon,  8 Sep 2025 13:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="a92aYAzt"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9248312DDA1
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 13:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757337079; cv=none; b=U9tpMISZV0gkOswSVacgRKoX2IE6JqNkUji2MWPHpNf3/bFCynF6B3ObyMk/njjBKgtBvTeCH+iyO5CjuldFjyDqPFfgOraMWMMp1cJeLXxKNsI3SaJTyGl7IXnJ8daadCIBFCdadP+UxglLrJ8RaHV+3HRgJPOgDmsPNKunyXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757337079; c=relaxed/simple;
	bh=U0kXuH7wwN7QWxoYSQPKY7Q6TxlEDakVd8Nu76xiStU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TzN5tKj1zRZ2PfEJDLqTuAZEqywn3w3j//6ZWUrqgpKzkv10uEf7aqfnAe8Pd7VaIhXqHkyVwgeM89cKbBXuVf3qREv7vEm0c7Yov6YBPzvay/X5MtqMUMKSSqvHNP/WXaK1xXqkXVQJATnpNhnAiZ2RCOv/56sCeduh0P2RSJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=a92aYAzt; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55f6ad5146eso4100532e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 06:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757337074; x=1757941874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AtaVnfyUFEfxnqjjSnpK4rRY532ZKtnmnioygkVKh1o=;
        b=a92aYAztj47L3grzXnoSAPF80aoY7gAS4JbJA3E7Y/5uRFuxX1NMvNlG9WeJD4PurP
         UgP+SRRgKcKNGzqpmbeEx4ByguXbscWNupOfDYn7wiSCPXzDiChTv46bE+9bQCH6kEyd
         IfQqctCi17ysPGTtBhxdud0yqDe4cSY0xzc2gUhlIYE2YjDhJ6v2ZJF1vF+GVgkPyynE
         /1uwkZsUKASV5FEpMTo3R9lHPASVKvJT8C7TKkI5HIi7fuK0XiQRoHj4zCGPkI8Wo4T/
         EwStIOnfU0blgCucJ5dpA9L9h/w5TsXca14VcqU7ASZefts7hylg9oHAlRBLgl0PdtrL
         A+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757337074; x=1757941874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AtaVnfyUFEfxnqjjSnpK4rRY532ZKtnmnioygkVKh1o=;
        b=WWxLfvUOfzKd7Ygz5R8uA/lj5dTO2yPiawkEtwRbrwiNRMNBp+NPsLhW9+SdfYU4k4
         fNCqT3/0YaoePC3sizT7Wv2mgDW9z0z0zGivgfjmzqjPdk/cNxUcHSK/iiSE7KPE+pX1
         8zNPKFyJ+0V+I+Ljq1oMx/zWUHyVK+y995cKJdQP7hYq7BOVWX+u0Xn2RnC5aSC3tKOq
         pWenhVNemYTyB+Jvpf72T/0xlHVvW3e8sZE0NTE7BsnElacxdjjk0rpvGMgmV4Vbx2je
         MxKRdXdsPY9+hj4Gv0r0hkIoNoRJNq/BMSzEdYgGwaPtmBQ3qZRRYcb/UVxTYYtAMIpc
         0kEw==
X-Gm-Message-State: AOJu0YzZeCMnylQ2Zlie0SByw6OKyRZMcuLc0+VNlVsbOul1zYPwTqD/
	tF+NGr+Q2yY3I5TlfmL/3BOxGRopQRZMiDrhcb83tx3PXYU/dtWdvUv7+4y5Xg00mwpE7yz7yy6
	LgQyXEjENJuyLaaz492z6tJfMn1uZEmgTLKQodaKYVf2HyZXEptT3h1M=
X-Gm-Gg: ASbGncv51ipW6IEERy1wh9GtY6/EoKhgqJYLF5No0p4L3/JVzBHQzqcAfKXu3xRw/j/
	vnbbNhaN8Bh4ax56U/3jifRAlIYi2W3i2InkPSTNjiJo3qIfV5+QmQwUknGAMYtD8cAOjR46VEN
	cSHLC3XFGYrsXcyYnE7QvBlRdz2td5plgaU4djwZYiMk5ewqc0SY9idjpN3s2CFqMYSn+70FMog
	6AXgVNlq0hpvainjA6PXhZaHcjjPSlBzD2nhv7c0bg/2ctTZ4o=
X-Google-Smtp-Source: AGHT+IF2J3UftmSRUNFNM97EpuUrbHTRbXwpg7cT2WNP7NKSvr98Iiz7q7iNkLQzvv/p/faqNxouRTnQLnPVJDT36gY=
X-Received: by 2002:a05:6512:b8a:b0:55f:43ab:b220 with SMTP id
 2adb3069b0e04-562619d7f5dmr2213343e87.34.1757337074462; Mon, 08 Sep 2025
 06:11:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905091325.112168-1-marco.crivellari@suse.com>
 <20250905091325.112168-4-marco.crivellari@suse.com> <aLsdBIY01140Vyy_@slm.duckdns.org>
In-Reply-To: <aLsdBIY01140Vyy_@slm.duckdns.org>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 8 Sep 2025 15:11:03 +0200
X-Gm-Features: Ac12FXxee5iYluWOFYT9PKkhYmZXaxoSldhodg8zjixNJRbfJjWPXxjlNHh5LkY
Message-ID: <CAAofZF4Wzf9kyvL_HY6uKyGvvrcnLQ0tJLnM+pKG9kXYV9My5g@mail.gmail.com>
Subject: Re: [PATCH 3/3] workqueue: WQ_PERCPU added to alloc_workqueue users
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 7:25=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
> Isn't this missing WQ_PERCPU for system_freezable_power_efficient_wq?

I guess the flag is also missing for system_power_efficient_wq,
because by default
it should be per-cpu, unless there is  wq_power_efficient=3Dtrue.

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

marco.crivellari@suse.com

