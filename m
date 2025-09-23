Return-Path: <linux-kernel+bounces-829329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C693DB96D10
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5A8E7A4012
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BC2322DCF;
	Tue, 23 Sep 2025 16:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwupfOZ0"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E131EE7B7
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 16:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758644759; cv=none; b=ksnaw9Dn3JZ6k0I385eOU1df0tZu4QoF4D2/4UNODxm6Z4Jeh14vR1mrAoDlB1dqR+s8yNxZgJvHnIdNW7iTSm+7YmIWHosO2bDkbDzz49tBTWvuREnjx8jMt72dWKY/1750gNdRRG2LIJLdilpMY7kdXOIYKN0Q/xvn8mUOEVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758644759; c=relaxed/simple;
	bh=N5mgVPRo+CPk2ySaxtFkjus+k/V2WydmtZQlE+k35h4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHr8URVFafFmB0mvKelDZoOM5eKcS5fuyM/rFG+qXymCXs6+W7YxAvxPBvArK7S3vW+ffRG1G3yphJUZ9bfsUn/Aajb9poJJiXTHX8FsgBlThdpz2y5PZA/2zYcUURzwTn2BMbxI7/pv1HU2J6HVoqPubv4SzY+yljXqdXrRqeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwupfOZ0; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ece1102998so3725755f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758644754; x=1759249554; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IvBR/uuNoM05F0Kk2G6oFxp0yBhFbfSrXeNiw0n2Ztw=;
        b=SwupfOZ0T2gm1tYUiw7SBXyroHOI4oAqQrS7wKbxqu1fh9SGZBd+Bl/1JW7auj6sMn
         IFqadrkhyItkwDeC33IfnQsF2+E9R2X3rAOvMmAaI1vzTVijHX8x89VQVMRG6kcD1JRj
         9hoyGWNpZsJAqaTqBw5N1Svx22wEKif6aZ4DtJcVSmsVvlxFW71s/3kxCMoKsxFQfiwJ
         xMgSTbhwEo/Qc0IjpgU5EsGnCaeB+qDYM7kYZKg+GmDG3kBd2Ddd/u0P0HEoLqCU7WB8
         zQdGpRNadH+/R8v0pokBgY2yXOvBJY0e9otj/VJ3vmVKG9iVoqV5ykQ+yeB/dvE9uFxP
         AbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758644754; x=1759249554;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IvBR/uuNoM05F0Kk2G6oFxp0yBhFbfSrXeNiw0n2Ztw=;
        b=dT3fserD0rgWBh0K+47wwO3pXSK6st6zii1BW1pzAVsmNbdzu2wMTGh8eoOvvB6CYh
         BXygHa6WyTdyTLs1g5dPSfaOnfdJgApmXX8DWL0fbfojMbo8eQfhuFKX4nNec+wcFBiS
         ohex3d4QTsYMFrMAwuR3+l29mU0M8M7qymwjYMbI2rBDkdImMdzc6OSXDVnwL2bHPweo
         6QLye42IULeNPtbR7VJLe2J68eJYz8bAI4G/XcQn88G+K+vJlUbmyumampljKrWEBE1f
         kkX75/IfP9mvbhtF9/+7gCH4LlUhvr4H99D2qNGLBZHCPvVl3UNtRAV6NZAtjeGjoEt8
         RTKw==
X-Forwarded-Encrypted: i=1; AJvYcCXw97wIoL+URcwwgffOeUojqG3KvLMPcdcM7YYKRDT3TT6gDYPUZv+S+wEnAW5WfogDctIVx4haeCgCl0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPYDfSizxQoZE6q8vHd3wLvHpCdIvMvebLZQyFjywabjao/2H+
	K0N3Bte19iQDL42owLbkU9zb6NqzPkwUaRYCKeq0U+65O1iIzVdwdaVI
X-Gm-Gg: ASbGncuC8uNDtcD9i1AWxJCsMTogj199T2pntRCca8mABi6+5zVm2UYr3oZ6PoHJCV2
	+3aEpWRH8p/+929lOMWwfYEjfQuy4yUaGIuv0z+4bTxUT2Wp1VFHqjtUKnMZgPOwdvOO/eglTUk
	vWwCmGmhb8z4UDyWy3eRDl3bNHZwRjmxNtYIk7qT09o8dbAHl48/LhoiyIfcqfzNe6cdrHd+BQg
	9RS8dv+Joc9dbPhIPAhGonn9SISa8LYQ2ppiVAGkpkw1O/15i7YQstZx2ozMPJEHY9kUMBKhagR
	+DOIvwQnAs3rV+PxhEJENBJ3QIC6/3k+ze2Nzm1AUTGKGvtFz+e+oKKcTtvxiRLo5CAv9YTk50u
	5X/Dxf7NPTfA=
X-Google-Smtp-Source: AGHT+IHrFSATwyg3qRX5k56eKwBNcVQdxs7GBs4B3KV5AJlT4F8HQe8L3ySqDT1kugqd/sLfdFZJ1w==
X-Received: by 2002:a05:6000:430c:b0:3f0:2ab8:710f with SMTP id ffacd0b85a97d-405c3c3e243mr2955512f8f.8.1758644754154;
        Tue, 23 Sep 2025 09:25:54 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3fd84338ca2sm9347726f8f.42.2025.09.23.09.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 09:25:53 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 23 Sep 2025 18:25:52 +0200
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Jiri Olsa <olsajiri@gmail.com>, mhiramat@kernel.org,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH 2/2] tracing: fprobe: optimization for entry only case
Message-ID: <aNLKEJc6Bh-dC3ab@krava>
References: <20250923092001.1087678-1-dongml2@chinatelecom.cn>
 <4681686.LvFx2qVVIh@7940hx>
 <aNKRoKTAmKpafk4F@krava>
 <5938379.DvuYhMxLoT@7950hx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5938379.DvuYhMxLoT@7950hx>

On Tue, Sep 23, 2025 at 09:34:20PM +0800, Menglong Dong wrote:
> On 2025/9/23 20:25, Jiri Olsa wrote:
> > On Tue, Sep 23, 2025 at 07:16:55PM +0800, menglong.dong@linux.dev wrote:
> > > On 2025/9/23 19:10 Jiri Olsa <olsajiri@gmail.com> write:
> > > > On Tue, Sep 23, 2025 at 05:20:01PM +0800, Menglong Dong wrote:
> > > > > For now, fgraph is used for the fprobe, even if we need trace the entry
> > > > > only. However, the performance of ftrace is better than fgraph, and we
> > > > > can use ftrace_ops for this case.
> > > > > 
> > > > > Then performance of kprobe-multi increases from 54M to 69M. Before this
> > > > > commit:
> > > > > 
> > > > >   $ ./benchs/run_bench_trigger.sh kprobe-multi
> > > > >   kprobe-multi   :   54.663 ± 0.493M/s
> > > > > 
> > > > > After this commit:
> > > > > 
> > > > >   $ ./benchs/run_bench_trigger.sh kprobe-multi
> > > > >   kprobe-multi   :   69.447 ± 0.143M/s
> > > > > 
> > > > > Mitigation is disable during the bench testing above.
> > > > > 
> > > > > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > > > > ---
> > > > >  kernel/trace/fprobe.c | 88 +++++++++++++++++++++++++++++++++++++++----
> > > > >  1 file changed, 81 insertions(+), 7 deletions(-)
> > > > > 
> > > > > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > > > > index 1785fba367c9..de4ae075548d 100644
> > > > > --- a/kernel/trace/fprobe.c
> > > > > +++ b/kernel/trace/fprobe.c
> > > > > @@ -292,7 +292,7 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
> > > > >  				if (node->addr != func)
> > > > >  					continue;
> > > > >  				fp = READ_ONCE(node->fp);
> > > > > -				if (fp && !fprobe_disabled(fp))
> > > > > +				if (fp && !fprobe_disabled(fp) && fp->exit_handler)
> > > > >  					fp->nmissed++;
> > > > >  			}
> > > > >  			return 0;
> > > > > @@ -312,11 +312,11 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
> > > > >  		if (node->addr != func)
> > > > >  			continue;
> > > > >  		fp = READ_ONCE(node->fp);
> > > > > -		if (!fp || fprobe_disabled(fp))
> > > > > +		if (unlikely(!fp || fprobe_disabled(fp) || !fp->exit_handler))
> > > > >  			continue;
> > > > >  
> > > > >  		data_size = fp->entry_data_size;
> > > > > -		if (data_size && fp->exit_handler)
> > > > > +		if (data_size)
> > > > >  			data = fgraph_data + used + FPROBE_HEADER_SIZE_IN_LONG;
> > > > >  		else
> > > > >  			data = NULL;
> > > > > @@ -327,7 +327,7 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
> > > > >  			ret = __fprobe_handler(func, ret_ip, fp, fregs, data);
> > > > >  
> > > > >  		/* If entry_handler returns !0, nmissed is not counted but skips exit_handler. */
> > > > > -		if (!ret && fp->exit_handler) {
> > > > > +		if (!ret) {
> > > > >  			int size_words = SIZE_IN_LONG(data_size);
> > > > >  
> > > > >  			if (write_fprobe_header(&fgraph_data[used], fp, size_words))
> > > > > @@ -384,6 +384,70 @@ static struct fgraph_ops fprobe_graph_ops = {
> > > > >  };
> > > > >  static int fprobe_graph_active;
> > > > >  
> > > > > +/* ftrace_ops backend (entry-only) */
> > > > > +static void fprobe_ftrace_entry(unsigned long ip, unsigned long parent_ip,
> > > > > +	struct ftrace_ops *ops, struct ftrace_regs *fregs)
> > > > > +{
> > > > > +	struct fprobe_hlist_node *node;
> > > > > +	struct rhlist_head *head, *pos;
> > > > > +	struct fprobe *fp;
> > > > > +
> > > > > +	guard(rcu)();
> > > > > +	head = rhltable_lookup(&fprobe_ip_table, &ip, fprobe_rht_params);
> > > > 
> > > > hi,
> > > > so this is based on yout previous patch, right?
> > > >   fprobe: use rhltable for fprobe_ip_table
> > > > 
> > > > would be better to mention that..  is there latest version of that somewhere?
> > > 
> > > Yeah, this is based on that version. That patch is applied
> > > to: https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git/log/?h=probes%2Ffor-next
> > > 
> > > And I do the testing on that branches.
> > 
> > did you run 'test_progs -t kprobe_multi' ? it silently crashes the
> > kernel for me.. attaching config
> 
> Hi. I have tested the whole test_progs and it passed.
> 
> In fact, your config will panic even without this patch.
> Please don't enable CONFIG_X86_KERNEL_IBT, the recursion
> of the is_endbr() still exist until this series apply:
> 
>   tracing: fprobe: Protect return handler from recursion loop

ugh, I thought it's there already, thanks

jirka

