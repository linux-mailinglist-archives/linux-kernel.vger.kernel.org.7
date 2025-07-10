Return-Path: <linux-kernel+bounces-725854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1661B004BA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C031516F2BA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0A5270EDE;
	Thu, 10 Jul 2025 14:03:27 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B353F25BF14
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 14:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752156207; cv=none; b=ZN7l9It6R2yJ2V5kqv4veH2fku9TvWQaOIJHjjcQnZ20iBqJ08AZYAYAo7vv781hB3Z12Q1HptxX60AnxNr3oG1zNo0u4diWFBn+zmAqJVLiYUBosPQriJXrAQBl5YImGM6TbqgDBJj1pCy/MsC79ym3ixeoKzJyWlvZXjgSciE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752156207; c=relaxed/simple;
	bh=G9OFlBoVM/360s/f6gIgxfzYL97pP+USn5B8Yd4Bu58=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BCrelSixmMk/lW7FfZIu/cJ6Szg6Kw5lSJ7q/2FUBkYo3dnniIjUdoPXn+eqCL7PVnCOeJK3do69F9SrzLt9Le5GmtdTWTDAX1P4ZYaAx7UWj1p2fcPma+hF7xca4GeNgN0fD9t29BCb/bctfPlqVfEslkryMNunEy72iT53mNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 0E1148012C;
	Thu, 10 Jul 2025 14:03:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 4B12C20025;
	Thu, 10 Jul 2025 14:03:11 +0000 (UTC)
Date: Thu, 10 Jul 2025 10:03:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: Christian Loehle <christian.loehle@arm.com>, xuewen.yan@unisoc.com,
 vincent.guittot@linaro.org, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, hongyan.xia2@arm.com, linux-kernel@vger.kernel.org,
 ke.wang@unisoc.com, di.shen@unisoc.com, xuewen.yan94@gmail.com,
 kprateek.nayak@amd.com, kuyo.chang@mediatek.com, juju.sung@mediatek.com,
 qyousef@layalina.io
Subject: Re: [PATCH v1] sched/uclamp: Exclude kernel threads from uclamp
 logic
Message-ID: <20250710100311.15cc55ce@batman.local.home>
In-Reply-To: <554d1da1-8b35-489c-973d-b5d5dba31403@kylinos.cn>
References: <20250703091437.79861-1-zhangzihuan@kylinos.cn>
	<675563a5-8f1d-4249-9828-9fb353dd7dd1@arm.com>
	<6414cb05-11d3-4b2a-ae97-7bb0ca0ea898@kylinos.cn>
	<20250703105147.13e10a77@batman.local.home>
	<554d1da1-8b35-489c-973d-b5d5dba31403@kylinos.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: jbp5cfsiyewirab9rb5xgcs8g54wxkkb
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 4B12C20025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/yJzxp3EcNOybM/kmSCkRrOqzWYe/E9yE=
X-HE-Tag: 1752156191-220380
X-HE-Meta: U2FsdGVkX1+JdTIbVY3rK5XFzqPQcC8rThiy2rvd8+Arj5UjRw89o0sTlqcFpuZSzatrGJSDTYtHYrIZnem8Hc+wxDmo4h+coVDOk6tMKonGZyCT5/gP+PvTCO+hGPaQw4fxP0JjJPimGW46vYSTSCJ8Mc8hdkyc6KNW7tnX2ruevp9Fx/pZJy0jvH1PCfzXfKsZz0ixiVptRr3OWy40RncB6qsNEoNDeLOLcq6BU3nRpXhlfraCsJknTiAxOR9dCHzPT1q3msYIGakyISzTWSwTXbbgADxsNPdCj76amdmRNuMgYQTVWthaQg/Mjrb5on2zpAsmwnePME+vOdUqcskNvVr3o/Ri

On Thu, 10 Jul 2025 08:55:28 +0800
Zihuan Zhang <zhangzihuan@kylinos.cn> wrote:

> The motivation behind this patch is to explore whether it=E2=80=99s worth=
=20
> optimizing the uclamp hot path a bit further. Since kernel threads=20
> typically don=E2=80=99t benefit from uclamp adjustments and often just in=
herit=20
> default values (e.g., max=3D1024), we were wondering if skipping the=20
> aggregation logic for such cases could slightly reduce overhead in some=20
> workloads.
>=20
> Of course, we want to be conservative and avoid breaking any legitimate=20
> usage. So I=E2=80=99d love to hear your opinion =E2=80=94 do you think it=
=E2=80=99s worthwhile=20
> to pursue this kind of micro-optimization in uclamp, or is the potential=
=20
> gain too marginal to justify the added logic?

My honest opinion is that if there's not a huge issue you are trying
to solve, then it's best to leave things as is. Tweaking this for
micro-optimizations usually end up causing a regression somewhere you
never expected.

-- Steve

