Return-Path: <linux-kernel+bounces-821205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF426B80BC9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCCEF16EB1D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD292FD1B0;
	Wed, 17 Sep 2025 15:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dmQca/Fa"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED482F7442
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123925; cv=none; b=FdfQp7TiOVj1P3rCEQTlGDHobUchBpuwDH1hTENOy468FzeRaIrIue8D+03z9BCZ977kYSuUqASZZQ0egdX8ghN0xjGUgVOhAKHXFskD+INBsdrIesYGoVYLUG8srutDtZukuHP10/V9IHe3b3+NFGfgGWD+UvjbE6wBvK3O9MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123925; c=relaxed/simple;
	bh=sz7SYILff82DqDpxJ+4+erabvkbgg/Mq/k7fYb0hsCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e5DKfK3Ti8VUNzjUTrkiVHtyViaO/537MYkFJ/qo93nAcKEIttfzi39WVAzedu8hfrMhPpf7WWGuCI9uSZGv5qZ9rfbBeK3yPuZgpsj8c0iXVFzekab0rSzO7JrSGPU+V3/ptVUy5o/ouAY/JuMcqSJpFw/dBBcKs76k3oZ1qDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dmQca/Fa; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-336dc57f562so9469451fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758123920; x=1758728720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sz7SYILff82DqDpxJ+4+erabvkbgg/Mq/k7fYb0hsCk=;
        b=dmQca/FaBOY0gnQJKQvFZb/KZL2u1gu/netj69fp0mrbA9nY3lUC+fEoidrFyXNz20
         0cR99orveHey/KGAVdiNhpaS+nbVKLAVgLy76QKJbi454MJksAra2WEslHaCR3x+Yo08
         6x9SNTesyVQRl9jhI79SQzOKc8AtplmaR/r0WAstT/5p0C+1RD1I+Ew1Q6bfdWOftb9w
         juugSoNEhKEQRAtC0YX+be9n+I0MalK72q0pFHAWHKiwyUxPmGLIaVQFt+kUBQGcLWkY
         zQxk0IQSQG9Od3PU7ONZj36cY3fX4cAug34T/jyxiMNtMjoFZj/+JEPRfEHz+k/j44Cj
         XUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758123920; x=1758728720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sz7SYILff82DqDpxJ+4+erabvkbgg/Mq/k7fYb0hsCk=;
        b=g2hXsS8Y91SGN45B/+LY7VeCzYK4CiQ0QwMbjuABDWN4avlNXtMPgRVRtIga2J52cv
         o4fI+eDdTgaWUIqsZ8rIB5WiFh07dCmnvSmq7gef9Z13wxwKwKEPV5ekurVXEhf/pUtj
         gmStgcJH7VjehVvybBwBs4IF9K4M3Vxhlll8UtnipE/cHIGzAnwBV9/ORLcxdcF/mHP2
         HQlQs7DDVq0G6EYfSZGXPIZ9d/Hoxxp25D0C0I/l/D9+vGKcNwYRrrAIIt4s3AAqlUzt
         yBxFR9pb4/it4QVmc/JaT0saynJVQqMVsTJyTHXLNMFiz9o76vQqvC6I3xRqXTMHDxZl
         maWw==
X-Gm-Message-State: AOJu0YziE/WkZViMvjt4FWLBcKGneINn7QTxdiytn+Q5cL7qCAHnYeRv
	B7jbG54FCldIvYbolK16piLPht9Zuo4+CVKMFdfdI40Lcc6zkj3njLIe/RfKnINfvWZdl7qnkRm
	OofP7tnFrWE1kdo/B94wgwQrMNP6XBVBhAC7I/AADJQ==
X-Gm-Gg: ASbGncvryrepqVTNLnS3UdfGEGo8Q2VdgMI0PINeutuEh/9tlUpNB9bc00yixCBw8mz
	pXkiRcbReuAYpe+TYrORaGm/9u+fRDCI4elNgMwqQVigdRo2aUmTAGDiNUxCmczA8ApbEKebzaG
	4yGNpkR4BVFdq2QPseMO4eqRfVjMKVwbgFkMJu0xTOCxkvL4HfgsSM1r8bW7UXjhelepY4qyMfm
	PkWbPpk/vuKEZEWOk94zvf81gmX7KO/rfpvIIDl
X-Google-Smtp-Source: AGHT+IHaQop1vRGZ5Gk+j1PzwXk+VYonaqfFJM7yvDR050nmE4+hPgSj1kpGWDRYAvKK2mxhuA23eHMkUjo7qjvxHUU=
X-Received: by 2002:a2e:a615:0:b0:360:3acd:e3a8 with SMTP id
 38308e7fff4ca-3616c671504mr316881fa.10.1758123920295; Wed, 17 Sep 2025
 08:45:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905090953.109082-1-marco.crivellari@suse.com>
 <20250905090953.109082-2-marco.crivellari@suse.com> <77b495f8-177d-4977-9d09-1dffc29db269@paulmck-laptop>
In-Reply-To: <77b495f8-177d-4977-9d09-1dffc29db269@paulmck-laptop>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 17 Sep 2025 17:45:08 +0200
X-Gm-Features: AS18NWAsOEJGo8EtUKJm47DROikfEhUYQ0-D6YnIBL6bh6Q5V5-FKnG25GD6-2w
Message-ID: <CAAofZF78KLU0-qj5EdvYnYGw4suCRcKHwQpAcHxUc7V8-q+P0w@mail.gmail.com>
Subject: Re: [PATCH 1/1] smp: replace use of system_wq with system_percpu_wq
To: paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, Ingo Molnar <mingo@redhat.com>, 
	Rik van Riel <riel@surriel.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 4:24=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

Thank you!


--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

