Return-Path: <linux-kernel+bounces-829006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0AAB9606D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8BEF19C3B0C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C3C32779B;
	Tue, 23 Sep 2025 13:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aMCLsoip"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C542D8371
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 13:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758634480; cv=none; b=g9h9pow8bcvB1TfDHfAoU0OZj9NP0RtueK1lx8HdSkOF9Fu9bu1zDFuX/n1vrrtDcBCoUS+XmyeX446NetpKjgjTO7LgzhBO5JaSUi0C6p2z+q4FN7uCfHckonwcyCsKbyLfqYI5RPf0WMn26A9K2+ySUMOlc8s9todjAOoIiFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758634480; c=relaxed/simple;
	bh=u7oEvXsps4gM6bLJm1v9nTNaPe+i34OPp3gcLJGAhHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E20UWtiXYdiH/67ZQ0hEMq20KXJF2+lF0hYVClTEmn0mbN26hP1baQ0hBwSvR1xYnBOGpxCVGxwb4TT9UtNsYl4rQoxOU5O7ug7bfCOTNjXyCwecbqVrSI355FqDJgO5BXGOZy5naJtkRFmJDtMhZK52rMGIrFJ++7saDwVydQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aMCLsoip; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758634473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kHfWCvv+MDYhkLFWkNZpUD65PMmDuEXuyHvDsjW9Fks=;
	b=aMCLsoiplGJGCYSr2CEESBjyy3ZM0l6/cZLxDpGPBScX5ssxERBQFJFgSLM66REMYwJjEA
	uyYWfkAxMY/B9aCPWZ6m0sw+XrENDJk8pqJgD42FEddeaj/PtPEBPM74iExgLlyrnfBZda
	ACiFSCKnvF9PnLfUQSKC2Btk8gZUfXE=
From: Menglong Dong <menglong.dong@linux.dev>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, mhiramat@kernel.org, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 2/2] tracing: fprobe: optimization for entry only case
Date: Tue, 23 Sep 2025 21:34:20 +0800
Message-ID: <5938379.DvuYhMxLoT@7950hx>
In-Reply-To: <aNKRoKTAmKpafk4F@krava>
References:
 <20250923092001.1087678-1-dongml2@chinatelecom.cn>
 <4681686.LvFx2qVVIh@7940hx> <aNKRoKTAmKpafk4F@krava>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/9/23 20:25, Jiri Olsa wrote:
> On Tue, Sep 23, 2025 at 07:16:55PM +0800, menglong.dong@linux.dev wrote:
> > On 2025/9/23 19:10 Jiri Olsa <olsajiri@gmail.com> write:
> > > On Tue, Sep 23, 2025 at 05:20:01PM +0800, Menglong Dong wrote:
> > > > For now, fgraph is used for the fprobe, even if we need trace the e=
ntry
> > > > only. However, the performance of ftrace is better than fgraph, and=
 we
> > > > can use ftrace_ops for this case.
> > > >=20
> > > > Then performance of kprobe-multi increases from 54M to 69M. Before =
this
> > > > commit:
> > > >=20
> > > >   $ ./benchs/run_bench_trigger.sh kprobe-multi
> > > >   kprobe-multi   :   54.663 =C2=B1 0.493M/s
> > > >=20
> > > > After this commit:
> > > >=20
> > > >   $ ./benchs/run_bench_trigger.sh kprobe-multi
> > > >   kprobe-multi   :   69.447 =C2=B1 0.143M/s
> > > >=20
> > > > Mitigation is disable during the bench testing above.
> > > >=20
> > > > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > > > ---
> > > >  kernel/trace/fprobe.c | 88 +++++++++++++++++++++++++++++++++++++++=
=2D---
> > > >  1 file changed, 81 insertions(+), 7 deletions(-)
> > > >=20
> > > > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > > > index 1785fba367c9..de4ae075548d 100644
> > > > --- a/kernel/trace/fprobe.c
> > > > +++ b/kernel/trace/fprobe.c
> > > > @@ -292,7 +292,7 @@ static int fprobe_fgraph_entry(struct ftrace_gr=
aph_ent *trace, struct fgraph_ops
> > > >  				if (node->addr !=3D func)
> > > >  					continue;
> > > >  				fp =3D READ_ONCE(node->fp);
> > > > -				if (fp && !fprobe_disabled(fp))
> > > > +				if (fp && !fprobe_disabled(fp) && fp->exit_handler)
> > > >  					fp->nmissed++;
> > > >  			}
> > > >  			return 0;
> > > > @@ -312,11 +312,11 @@ static int fprobe_fgraph_entry(struct ftrace_=
graph_ent *trace, struct fgraph_ops
> > > >  		if (node->addr !=3D func)
> > > >  			continue;
> > > >  		fp =3D READ_ONCE(node->fp);
> > > > -		if (!fp || fprobe_disabled(fp))
> > > > +		if (unlikely(!fp || fprobe_disabled(fp) || !fp->exit_handler))
> > > >  			continue;
> > > > =20
> > > >  		data_size =3D fp->entry_data_size;
> > > > -		if (data_size && fp->exit_handler)
> > > > +		if (data_size)
> > > >  			data =3D fgraph_data + used + FPROBE_HEADER_SIZE_IN_LONG;
> > > >  		else
> > > >  			data =3D NULL;
> > > > @@ -327,7 +327,7 @@ static int fprobe_fgraph_entry(struct ftrace_gr=
aph_ent *trace, struct fgraph_ops
> > > >  			ret =3D __fprobe_handler(func, ret_ip, fp, fregs, data);
> > > > =20
> > > >  		/* If entry_handler returns !0, nmissed is not counted but skips=
 exit_handler. */
> > > > -		if (!ret && fp->exit_handler) {
> > > > +		if (!ret) {
> > > >  			int size_words =3D SIZE_IN_LONG(data_size);
> > > > =20
> > > >  			if (write_fprobe_header(&fgraph_data[used], fp, size_words))
> > > > @@ -384,6 +384,70 @@ static struct fgraph_ops fprobe_graph_ops =3D {
> > > >  };
> > > >  static int fprobe_graph_active;
> > > > =20
> > > > +/* ftrace_ops backend (entry-only) */
> > > > +static void fprobe_ftrace_entry(unsigned long ip, unsigned long pa=
rent_ip,
> > > > +	struct ftrace_ops *ops, struct ftrace_regs *fregs)
> > > > +{
> > > > +	struct fprobe_hlist_node *node;
> > > > +	struct rhlist_head *head, *pos;
> > > > +	struct fprobe *fp;
> > > > +
> > > > +	guard(rcu)();
> > > > +	head =3D rhltable_lookup(&fprobe_ip_table, &ip, fprobe_rht_params=
);
> > >=20
> > > hi,
> > > so this is based on yout previous patch, right?
> > >   fprobe: use rhltable for fprobe_ip_table
> > >=20
> > > would be better to mention that..  is there latest version of that so=
mewhere?
> >=20
> > Yeah, this is based on that version. That patch is applied
> > to: https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.g=
it/log/?h=3Dprobes%2Ffor-next
> >=20
> > And I do the testing on that branches.
>=20
> did you run 'test_progs -t kprobe_multi' ? it silently crashes the
> kernel for me.. attaching config

Hi. I have tested the whole test_progs and it passed.

In fact, your config will panic even without this patch.
Please don't enable CONFIG_X86_KERNEL_IBT, the recursion
of the is_endbr() still exist until this series apply:

  tracing: fprobe: Protect return handler from recursion loop

Thanks!
Menglong Dong

>=20
> jirka
>=20
>=20




