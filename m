Return-Path: <linux-kernel+bounces-888655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CD698C3B7AB
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 14:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 79A8D34EE2D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 13:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B3933374E;
	Thu,  6 Nov 2025 13:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aQvJ8Ani"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66DC333452
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762437373; cv=none; b=DzRiwEFneaaUdIjUYPgcSuwcf01ufDpX7H3URjnaTxLL+JC+W1Oc93pP3dZue+nJuydlLPA8TIGlmV5F35fkgt0VfyL1ztn10ne7dUkjoJ+AVWjD/htoo/D/fAJ/PqZxwVusSF48y2BnyFp80qfDkn1okFiRB4rOBM1kO1VUefI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762437373; c=relaxed/simple;
	bh=ZPpQhyDHhNpxfLpiGm4CRVbvnPihivnOcOM0lRZzemM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V1dDfElbDRim0uBfRDVzqvYk0DTgui4vFN4ejps4JZ7GoQxn4xWA5B0wzkhuLSVhlzxVhjZxJ/tTVzgct6YHRPq2qvqEIJzJ//hjzbQw2fkJ2D8QJ4oap0RlBHDWp8J2tlCL9NkYTere5WIUV20U9hOb6J3QQuVtOBNtoa785II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aQvJ8Ani; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-591c9934e0cso1339995e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 05:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762437370; x=1763042170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPpQhyDHhNpxfLpiGm4CRVbvnPihivnOcOM0lRZzemM=;
        b=aQvJ8Ani2rXcZp0KronHCznYGT+jo9iZOJVjiZSpbiyqo0zfRFRUnibMISsNw2uspg
         piZ311m1yGMVRBJ5JBjQNuoeImD/mj61rJab3JAtJ1rErSujiDaTpJNbbtm+btDzsFOz
         OW6imnInPjMq21+QalAd1+Km1DR/x6h4Zco5QcmoX9hvf/PuCI59Hy6vU/8TMgGe/Yv7
         dS8HtSMYhLw+DxpBT1s85JRVoGVsi9h7ROOC8tATqYjgHOJ2QUAaFPKhYp6JHI8RKKlQ
         p2CAHDYafFQA4s+CDPrXSFNKjSj/8UG3wwU4my95i763OVRRZBr3U/95PWiQNibrSb8j
         1IZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762437370; x=1763042170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPpQhyDHhNpxfLpiGm4CRVbvnPihivnOcOM0lRZzemM=;
        b=Uf/M2lesCJnFCabdq9WiQbr3wn3rgw3WCbnUzBBQrbWERLsYuI6CHRzYdGF4Ixe13q
         VTXkGjFy81Hpcyns0D3vh//kByexyS8Lkn5zp0r6pEJkp3zaSZsnTFV9UVSbvRKeiF8I
         Eg/PKN+7/YSpmH38BYWBB5ghsxmLq9Za3b6RclG5cAfR2CN5XQJXazWqym9IJCDNZLQd
         mHef/0e0fls6mwoSlV94Tv8feMX9kWh2Uwl5sCIiPqWHubcYSOfKOHeS1CnCZSj/7ZJD
         cYvJdGSwhf/mrTqM0JmbraZXspMj7DXiMFR5KNa3pwcrnxODeCT+tM18c/bpFlHHrWli
         vjPQ==
X-Gm-Message-State: AOJu0Yy6mQXrBP1IAmjNgw/Zd/nfineV035HOsYCXsZJxHKeU9XpJGM6
	327Ccd3minLn9pOCYr+57Olq/Q9RkW+2lGMyyOBWRySr6gdJa21K8ENMbLR4dnnY4M+qfc01Cpy
	0/cJ5SaaRuwcOJ+cpZErT0i1JqULN7NwpLRP9zEBBTw==
X-Gm-Gg: ASbGnctztJA3X1X3sULLKPV+zoiUwYn3DU5KvkZ9j1EbnGz+w5bfGsuqJWpaxsLTf4P
	Atvr7ei30y/XWiDoxZ58q5FApzVX8ReHCPCWPXcSp6bpdhI8a71LqJD9duwv65FGIb5L/TEZ0K+
	aHLaoCqOBgkKKKbXo10REYIXDbSMqO26/GOiWg6TBCHJQze3wG25qmOAu3+YN00eY//rk5N/LTm
	0k5N5AbBYQkawMk8aLmhFbV5+WAFV7sEK31tYNR9iOWFVFI7gKYGiQJ/Miz6Eh+BcJlDlLjFjzv
	MQBoTCogtKg+eNjRxw==
X-Google-Smtp-Source: AGHT+IHadeGCsSw6vLW0o2Xb0vdkI4IV15hP6mQdsdQe6JrhOg4n3aixYIWsVub7wiQGQhZey3sQAwYdPAqMmx0hezU=
X-Received: by 2002:a05:6512:3b2a:b0:594:3570:3572 with SMTP id
 2adb3069b0e04-5943d55c3d3mr2274069e87.1.1762437369863; Thu, 06 Nov 2025
 05:56:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105103523.103622-1-marco.crivellari@suse.com> <wmsyc3b55efl6wiouxtk6bqwdfeqso35ngv7aaqi6es7vph5xj@u5rwq6cggp6s>
In-Reply-To: <wmsyc3b55efl6wiouxtk6bqwdfeqso35ngv7aaqi6es7vph5xj@u5rwq6cggp6s>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Thu, 6 Nov 2025 14:55:57 +0100
X-Gm-Features: AWmQ_blGnhS9A8EKpSUZ1d12grubOTDDgYZLJzvhA6q5RHnGd7chzUF44Rdxm-Q
Message-ID: <CAAofZF5do1HHSRP438d5-D+_1-z1x8s8Q-_eZiUpDu6Tx-0K6g@mail.gmail.com>
Subject: Re: [PATCH 0/4] replace system_wq with system_percpu_wq, added
 WQ_PERCPU to alloc_workqueue
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Wed, Nov 5, 2025 at 11:08=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> So neither of these 4 need percpu workqueue and instead are fine to use
> "whatever is free". Maybe we can switch them to use unbound workqueues
> instead?

Sure, I will send the v2 with the unbound workqueue.

Thanks!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

