Return-Path: <linux-kernel+bounces-630460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1AAAA7A83
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 22:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B92B21C05592
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 20:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8373D1BD9F0;
	Fri,  2 May 2025 20:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzJjLPgo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411321EB18E;
	Fri,  2 May 2025 20:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746216118; cv=none; b=tJPLUgsAdog+lE7710sG8c579aOfcPTs4tBc2vFFLWu9ENscPEXJqGsFZJx9qRIXQZbzlKu9kO3Op9hRpQ1eklH0qurg5IHmt93ABYbfHRBR7N9D+bD72gy2WiTIUqarZsyvF3DyogZ6nDW8LY8X/HG4B1bFVKxQpNTyjPB8Y54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746216118; c=relaxed/simple;
	bh=afzi4k+0bfelLgQP8nQWjr6bV4NrhF6et/xtBXY7iOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ewbg4cknRGVq7BdQ00loSUcHEwROuntoxkI3xgRRxR5sBUKJwEJDaHTY0wRONKlVbLcil5yLWmFzvyfLZlIcceg914Af1xFFumSAKANVMn8yisL37ZcDsjNnSITW81U3uQiflpjYjf28dLbMGJNY5RHY7RXfLxOGfAYDnpGUjF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzJjLPgo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441B6C4CEE9;
	Fri,  2 May 2025 20:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746216117;
	bh=afzi4k+0bfelLgQP8nQWjr6bV4NrhF6et/xtBXY7iOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LzJjLPgodlMXJvyESgIx/h/Md9EOmcVgbhokXBkRFiZ2XF+gnM+vGb0UFW1ZBszsz
	 TR+BRw/dpRkriWbctJnaMll8TZ02cgiDkYDwHwr+ijlXrQ/LdDpav4a2xVigxmlAiA
	 +kPf5cf/7SwvuUAKfebVMhYZ6FoEFJvVdMPpa3LiXZFH33papE5WGXHVWghE7mStsC
	 ue/eXOHg5wo7GQybtQMMX+/wmq171dm5SpR4qkO+Xj4v+edyTnLUYfPyjeJwooUHF1
	 1SXDgQfPO1QV+rd9UgBGXePFfaf35WU8y+lAGM/GxWDoEeU8YJF3w4OIlxglQHB5Is
	 BfA8doBeieLew==
Date: Fri, 2 May 2025 13:01:55 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>, Leo Yan <leo.yan@arm.com>
Subject: Re: [PATCH 11/11] perf mem: Add 'dtlb' output field
Message-ID: <aBUks5W6fryDabJL@google.com>
References: <20250430205548.789750-1-namhyung@kernel.org>
 <20250430205548.789750-12-namhyung@kernel.org>
 <aBTzK_vZ0kBh9CLV@x1>
 <aBURK58syHRV9Eqx@google.com>
 <aBUbKXMS8oMYqxR9@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aBUbKXMS8oMYqxR9@x1>

On Fri, May 02, 2025 at 04:21:13PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, May 02, 2025 at 11:38:35AM -0700, Namhyung Kim wrote:
> > On Fri, May 02, 2025 at 01:30:35PM -0300, Arnaldo Carvalho de Melo wrot=
e:
> > > On Wed, Apr 30, 2025 at 01:55:48PM -0700, Namhyung Kim wrote:
> > > > This is a breakdown of perf_mem_data_src.mem_dtlb values.  It assum=
es
> > > > PMU drivers would set PERF_MEM_TLB_HIT bit with an appropriate leve=
l.
> > > > And having PERF_MEM_TLB_MISS means that it failed to find one in any
> > > > levels of TLB.  For now, it doesn't use PERF_MEM_TLB_{WK,OS} bits.
>=20
> > > > Also it seems Intel machines don't distinguish L1 or L2 precisely. =
 So I
> > > > added ANY_HIT (printed as "L?-Hit") to handle the case.
>=20
> > > >   $ perf mem report -F overhead,dtlb,dso --stdio
> > > >   ...
> > > >   #           --- D-TLB ----
> > > >   # Overhead   L?-Hit   Miss  Shared Object
> > > >   # ........  ..............  .................
> > > >   #
> > > >       67.03%    99.5%   0.5%  [unknown]
> > > >       31.23%    99.2%   0.8%  [kernel.kallsyms]
> > > >        1.08%    97.8%   2.2%  [i915]
> > > >        0.36%   100.0%   0.0%  [JIT] tid 6853
> > > >        0.12%   100.0%   0.0%  [drm]
> > > >        0.05%   100.0%   0.0%  [drm_kms_helper]
> > > >        0.05%   100.0%   0.0%  [ext4]
> > > >        0.02%   100.0%   0.0%  [aesni_intel]
> > > >        0.02%   100.0%   0.0%  [crc32c_intel]
> > > >        0.02%   100.0%   0.0%  [dm_crypt]
> > > >        ...
>=20
> > > root@number:~# perf report --header | grep cpudesc
> > > # cpudesc : AMD Ryzen 9 9950X3D 16-Core Processor
> > > root@number:~# perf mem report -F overhead,dtlb,dso --stdio | head -20
> > > # To display the perf.data header info, please use --header/--header-=
only options.
> > > #
> > > #
> > > # Total Lost Samples: 0
> > > #
> > > # Samples: 2K of event 'cycles:P'
> > > # Total weight : 2637
> > > # Sort order   : local_weight,mem,sym,dso,symbol_daddr,dso_daddr,snoo=
p,tlb,locked,blocked,local_ins_lat,local_p_stage_cyc
> > > #
> > > #           ---------- D-TLB -----------                             =
     =20
> > > # Overhead   L1-Hit L2-Hit   Miss  Other  Shared Object              =
     =20
> > > # ........  ............................  ...........................=
=2E.....
> > > #
> > >     77.47%    18.4%   0.1%   0.6%  80.9%  [kernel.kallsyms]          =
     =20
> > >      5.61%    36.5%   0.7%   1.4%  61.5%  libxul.so                  =
     =20
> > >      2.77%    39.7%   0.0%  12.3%  47.9%  libc.so.6                  =
     =20
> > >      2.01%    34.0%   1.9%   1.9%  62.3%  libglib-2.0.so.0.8400.1    =
     =20
> > >      1.93%    31.4%   2.0%   2.0%  64.7%  [amdgpu]                   =
     =20
> > >      1.63%    48.8%   0.0%   0.0%  51.2%  [JIT] tid 60168            =
     =20
> > >      1.14%     3.3%   0.0%   0.0%  96.7%  [vdso]                     =
     =20
> > > root@number:~#
> >=20
> > I guess it's because those samples don't have mem_info as they are not
> > memory instructions.
> >=20
> > Can you please re-run the perf record with filters like below?
> >=20
> >   $ perf record -aW --sample-mem-info -e cycles:P --filter 'mem_op =3D=
=3D load || mem_op =3D=3D store' sleep 1
>=20
> I tried, it got stuck for more than 1 second and then control+C took
> also a while and eventually:

I also saw some delay when using BPF.  I suspect it's BPF loader taking
long.

>=20
> root@x1:~# fg
> perf record -aW --sample-mem-info -e cycles:P --filter 'mem_op =3D=3D loa=
d || mem_op =3D=3D store' sleep 1
> ^X^C^C^C^Clibbpf: prog 'perf_sample_filter': BPF program load failed: -EA=
GAIN
> libbpf: prog 'perf_sample_filter': -- BEGIN PROG LOAD LOG --
> arg#0 reference type('UNKNOWN ') size cannot be determined: -22
> 0: R1=3Dctx() R10=3Dfp0
> ; kctx =3D bpf_cast_to_kern_ctx(ctx); @ sample_filter.bpf.c:215
> 0: (85) call bpf_cast_to_kern_ctx#72125       ; R0_w=3Dtrusted_ptr_bpf_pe=
rf_event_data_kern()
> 1: (7b) *(u64 *)(r10 -48) =3D r0        ; R0_w=3Dtrusted_ptr_bpf_perf_eve=
nt_data_kern() R10=3Dfp0 fp-48_w=3Dtrusted_ptr_bpf_perf_event_data_kern()
> 2: (b7) r6 =3D 0                        ; R6_w=3D0
> ; k =3D 0; @ sample_filter.bpf.c:217
> 3: (63) *(u32 *)(r10 -4) =3D r6         ; R6_w=3D0 R10=3Dfp0 fp-8=3D0000?=
???
> ; if (use_idx_hash) { @ sample_filter.bpf.c:219
> 4: (18) r1 =3D 0xffffa9e081be6000       ; R1_w=3Dmap_value(map=3Dsample_f=
=2Erodata,ks=3D4,vs=3D4)
> 6: (61) r1 =3D *(u32 *)(r1 +0)          ; R1_w=3D0
> 7: (15) if r1 =3D=3D 0x0 goto pc+42       ; R1_w=3D0
> ; k =3D *idx; @ sample_filter.bpf.c:239
> 50: (bf) r2 =3D r10                     ; R2_w=3Dfp0 R10=3Dfp0
> ; entry =3D bpf_map_lookup_elem(&filters, &k); @ sample_filter.bpf.c:244
> 51: (07) r2 +=3D -4                     ; R2_w=3Dfp-4
> 52: (18) r1 =3D 0xffff8ecc22be8000      ; R1_w=3Dmap_ptr(map=3Dfilters,ks=
=3D4,vs=3D1536)
> 54: (85) call bpf_map_lookup_elem#1   ; R0_w=3Dmap_value_or_null(id=3D1,m=
ap=3Dfilters,ks=3D4,vs=3D1536)
> 55: (bf) r6 =3D r0                      ; R0_w=3Dmap_value_or_null(id=3D1=
,map=3Dfilters,ks=3D4,vs=3D1536) R6_w=3Dmap_value_or_null(id=3D1,map=3Dfilt=
ers,ks=3D4,vs=3D1536)
> 56: (79) r5 =3D *(u64 *)(r10 -48)       ; R5_w=3Dtrusted_ptr_bpf_perf_eve=
nt_data_kern() R10=3Dfp0 fp-48=3Dtrusted_ptr_bpf_perf_event_data_kern()
> ; if (entry =3D=3D NULL) @ sample_filter.bpf.c:245
> 57: (15) if r6 =3D=3D 0x0 goto pc-21      ; R6_w=3Dmap_value(map=3Dfilter=
s,ks=3D4,vs=3D1536)
> 58: (b7) r8 =3D 0                       ; R8_w=3D0
> 59: (b7) r9 =3D 0                       ; R9_w=3D0
> 60: (b7) r1 =3D 0                       ; R1_w=3D0
> 61: (7b) *(u64 *)(r10 -40) =3D r1       ; R1_w=3D0 R10=3Dfp0 fp-40_w=3D0
> 62: (05) goto pc+9
> ; for (i =3D 0; i < MAX_FILTERS; i++) { @ sample_filter.bpf.c:248
> 72: (bf) r7 =3D r6                      ; R6=3Dmap_value(map=3Dfilters,ks=
=3D4,vs=3D1536) R7_w=3Dmap_value(map=3Dfilters,ks=3D4,vs=3D1536)
> 73: (0f) r7 +=3D r8                     ; R7_w=3Dmap_value(map=3Dfilters,=
ks=3D4,vs=3D1536) R8=3D0
> ; struct perf_sample_data___new *data =3D (void *)kctx->data; @ sample_fi=
lter.bpf.c:77
>=20
>=20
> <SNIP tons of verifier lines>
>=20
> 269: (65) if r2 s> 0x1 goto pc+28     ; R2_w=3Dscalar(smin=3Dsmin32=3D0,s=
max=3Dumax=3Dsmax32=3Dumax32=3D1,var_off=3D(0x0; 0x1))
> 270: (15) if r2 =3D=3D 0x0 goto pc+45     ; R2_w=3D1
> 271: (15) if r2 =3D=3D 0x1 goto pc+1      ; R2_w=3D1
> ; CHECK_RESULT(sample_data, !=3D, entry[i].value) @ sample_filter.bpf.c:2=
56
> 273: (bf) r2 =3D r6                     ; R2_w=3Dmap_value(map=3Dfilters,=
ks=3D4,vs=3D1536) R6=3Dmap_value(map=3Dfilters,ks=3D4,vs=3D1536)
> 274: (0f) r2 +=3D r8                    ; R2_w=3Dmap_value(map=3Dfilters,=
ks=3D4,vs=3D1536,off=3D984) R8_w=3D984
> 275: (79) r2 =3D *(u64 *)(r2 +16)       ; R2_w=3Dscalar()
> 276: (5d) if r1 !=3D r2 goto pc+101 378: R0_w=3D1 R1_w=3Dscalar(smin=3D0,=
smax=3Dumax=3D0xffffffff,var_off=3D(0x0; 0xffffffff)) R2_w=3Dscalar() R3_w=
=3Dptr_perf_sample_data() R4_w=3Dscalar(smin=3Dumin=3Dumin32=3D1,smax=3Duma=
x=3D0xffffffff,var_off=3D(0x0; 0xffffffff)) R5=3Dtrusted_ptr_bpf_perf_event=
_data_kern() R6=3Dmap_value(map=3Dfilters,ks=3D4,vs=3D1536) R7_w=3Dmap_valu=
e(map=3Dfilters,ks=3D4,vs=3D1536,off=3D984) R8_w=3D984 R9=3D0 R10=3Dfp0 fp-=
8=3Dmmmm???? fp-40=3D0 fp-48=3Dtrusted_ptr_bpf_perf_event_data_kern()
> 378: (67) r9 <<=3D 32                   ; R9_w=3D0
> 379: (bf) r1 =3D r9                     ; R1_w=3D0 R9_w=3D0
> 380: (77) r1 >>=3D 32                   ; R1_w=3D0
> 381: (b7) r9 =3D 0                      ; R9_w=3D0
> 382: (15) if r1 =3D=3D 0x0 goto pc-313    ; R1_w=3D0
> ; for (i =3D 0; i < MAX_FILTERS; i++) { @ sample_filter.bpf.c:248
> 70: (07) r8 +=3D 24                     ; R8_w=3D1008
> 71: (15) if r8 =3D=3D 0x600 goto pc-25    ; R8_w=3D1008
> 72: (bf) r7 =3D r6                      ; R6=3Dmap_value(map=3Dfilters,ks=
=3D4,vs=3D1536) R7_w=3Dmap_value(map=3Dfilters,ks=3D4,vs=3D1536)
> 73: (0f) r7 +=3D r8                     ; R7_w=3Dmap_value(map=3Dfilters,=
ks=3D4,vs=3D1536,off=3D1008) R8_w=3D1008
> ; struct perf_sample_data___new *data =3D (void *)kctx->data; @ sample_fi=
lter.bpf.c:77
> 74: (79) r3 =3D *(u64 *)(r5 +8)
> processed 2344 insns (limit 1000000) max_states_per_insn 4 total_states 5=
7 peak_states 57 mark_read 6
> -- END PROG LOAD LOG --
> libbpf: prog 'perf_sample_filter': failed to load: -EAGAIN
> libbpf: failed to load object 'sample_filter_bpf'
> libbpf: failed to load BPF skeleton 'sample_filter_bpf': -EAGAIN
> Failed to load perf sample-filter BPF skeleton
> failed to set filter "BPF" on event cpu_core/cycles/P with 11 (Resource t=
emporarily unavailable)
> ^Z
> [1]+  Stopped                 perf record -aW --sample-mem-info -e cycles=
:P --filter 'mem_op =3D=3D load || mem_op =3D=3D store' sleep 1
> root@x1:~#=20
> root@x1:~# fg
> perf record -aW --sample-mem-info -e cycles:P --filter 'mem_op =3D=3D loa=
d || mem_op =3D=3D store' sleep 1
> ^C^C^C^C^C
>=20
>=20
> ^C^C^C^C^C
>=20
> Well, I just had it suspended, I'm not being able to stop it:
>=20
> root@x1:~# ps=20
>     PID TTY          TIME CMD
> 1355566 pts/15   00:00:00 sudo
> 1355567 pts/15   00:00:00 su
> 1355570 pts/15   00:00:00 bash
> 1373907 pts/15   00:00:44 perf
> 1373908 pts/15   00:00:00 perf-exec
> 1374019 pts/15   00:00:00 ps
> root@x1:~# kill -9 1373907
> root@x1:~# kill -9 1373907
> -bash: kill: (1373907) - No such process
> [1]+  Killed                  perf record -aW --sample-mem-info -e cycles=
:P --filter 'mem_op =3D=3D load || mem_op =3D=3D store' sleep 1
> root@x1:~#=20
>=20
> Ok, killed.
>=20
> It gets stuck in that MAP_FREEZE sys_bpf call:

Interesting.

>=20
> root@x1:~# perf trace perf record -aW --sample-mem-info -e cycles:P --fil=
ter 'mem_op =3D=3D load || mem_op =3D=3D store' sleep 1
> <SNIP>
>  16349.552 ( 0.023 ms): perf/1374043 bpf(uattr: (union bpf_attr){(struct)=
{.map_type =3D (__u32)2,.key_size =3D (__u32)4,.value_size =3D (__u32)4,.ma=
x_entries =3D (__u32)1,.map_flags =3D (__u32)1152,.map_name =3D (char[16])[=
's','a','m','p','l','e','_','f','.','r','o','d','a','t','a',],.btf_fd =3D (=
__u32)61,.btf_value_type_id =3D (__u32)59,},(struct){.map_fd =3D (__u32)2,.=
key =3D (__u64)4294967300,(union){.value =3D (__u64)1152,.next_key =3D (__u=
64)1152,},.flags =3D (__u64)8101238451258523648,},.batch =3D (struct){.in_b=
atch =3D (__u64)17179869186,.out_batch =3D (__u64)4294967300,.keys =3D (__u=
64)1152,.values =3D (__u64)8101238451258523648,.count =3D (__u32)1717527916=
,.map_fd =3D (__u32)1685025326,.elem_flags =3D (__u64)6386785,.flags =3D (_=
_u64)61,},(struct){.prog_type =3D (__u32)2,.insn_cnt =3D (__u32)4,.insns =
=3D (__u64)4294967300,.license =3D (__u64)1152,.log_size =3D (__u32)1886216=
563,.log_buf =3D (__u64)7237128669819266412,.kern_version =3D (__u32)638678=
5,.prog_name =3D (char[16])['=3D',';',],.func_info =3D (__u64)1407359984460=
44,.func_info_cnt =3D (__u32)520807888,.line_info =3D (__u64)14073599844584=
8,.line_info_cnt =3D (__u32)4874802,.attach_btf_id =3D (__u32)4,(union){.at=
tach_prog_fd =3D (__u32)2805057752,.attach_btf_obj_fd =3D (__u32)2805057752=
,},.core_relo_cnt =3D (__u32)32767,.fd_array =3D (__u64)15131936,.core_relo=
s =3D (__u64)140735998445952,.core_relo_rec_size =3D (__u32)15049664,.prog_=
token_fd =3D (__s32)-1489909376,},(struct){.pathname =3D (__u64)17179869186=
,.bpf_fd =3D (__u32)4,.file_flags =3D (__u32)1,.path_fd =3D (__s32)1152,},(=
struct){(union){.target_fd =3D (__u32)2,.target_ifindex =3D (__u32)2,},.att=
ach_bpf_fd =3D (__u32)4,.attach_type =3D (__u32)4,.attach_flags =3D (__u32)=
1,.replace_bpf_fd =3D (__u32)1152,.expected_revision =3D (__u64)81012384512=
58523648,},.test =3D (struct){.prog_fd =3D (__u32)2,.retval =3D (__u32)4,.d=
ata_size_in =3D (__u32)4,.data_size_out =3D (__u32)1,.data_in =3D (__u64)11=
52,.data_out =3D (__u64)8101238451258523648,.repeat =3D (__u32)1717527916,.=
duration =3D (__u32)1685025326,.ctx_size_in =3D (__u32)6386785,.ctx_in =3D =
(__u64)61,.ctx_out =3D (__u64)59,},(struct){(union){.start_id =3D (__u32)2,=
=2Eprog_id =3D (__u32)2,.map_id =3D (__u32)2,.btf_id ) =3D 62

This line misses 'cmd:' part.  Probably it was 0 (MAP_CREATE).  It seems
we need to print the value even if it's 0.

>  16349.576 ( 0.002 ms): perf/1374043 dup3(oldfd: 62, newfd: 60<anon_inode=
:bpf-map>, flags: 524288)         =3D 60
>  16349.582 ( 0.001 ms): perf/1374043 close(fd: 62)                       =
                                  =3D 0
>  16349.586 ( 0.006 ms): perf/1374043 bpf(cmd: MAP_UPDATE_ELEM, uattr: (un=
ion bpf_attr){(struct){.map_type =3D (__u32)60,.value_size =3D (__u32)28050=
58140,.max_entries =3D (__u32)32767,.map_flags =3D (__u32)1994993664,.inner=
_map_fd =3D (__u32)32622,.map_ifindex =3D (__u32)2,.btf_fd =3D (__u32)28050=
58000,.btf_key_type_id =3D (__u32)32767,.btf_value_type_id =3D (__u32)16,.b=
tf_vmlinux_value_type_id =3D (__u32)48,.map_extra =3D (__u64)14073599844624=
0,.value_type_btf_obj_fd =3D (__s32)-1489909280,.map_token_fd =3D (__s32)32=
767,},(struct){.map_fd =3D (__u32)60,.key =3D (__u64)140735998446172,(union=
){.value =3D (__u64)140112418123776,.next_key =3D (__u64)140112418123776,},=
},.batch =3D (struct){.in_batch =3D (__u64)60,.out_batch =3D (__u64)1407359=
98446172,.keys =3D (__u64)140112418123776,.count =3D (__u32)7379400,.elem_f=
lags =3D (__u64)9110741168,.flags =3D (__u64)140735998446032,},(struct){.pr=
og_type =3D (__u32)60,.insns =3D (__u64)140735998446172,.license =3D (__u64=
)140112418123776,.log_buf =3D (__u64)7379400,.kern_version =3D (__u32)52080=
6576,.prog_flags =3D (__u32)2,.prog_name =3D (char[16])[208,201,'1',167,255=
,127,16,'0',],.prog_ifindex =3D (__u32)2805058208,.expected_attach_type =3D=
 (__u32)32767,.prog_btf_fd =3D (__u32)2805058016,.func_info_rec_size =3D (_=
_u32)32767,.func_info =3D (__u64)410826951296,.func_info_cnt =3D (__u32)487=
4930,.line_info =3D (__u64)40,.line_info_cnt =3D (__u32)1,.attach_btf_id =
=3D (__u32)4,(union){.attach_prog_fd =3D (__u32)520846144,.attach_btf_obj_f=
d =3D (__u32)520846144,},.fd_array =3D (__u64)60,.core_relos =3D (__u64)140=
735998445776,.core_relo_rec_size =3D (__u32)2805057752,.log_true_size =3D (=
__u32)524288,},(struct){.pathname =3D (__u64)60,.bpf_fd =3D (__u32)28050581=
40,.file_flags =3D (__u32)32767,.path_fd =3D (__s32)1994993664,},(struct){(=
union){.target_fd =3D (__u32)60,.target_ifindex =3D (__u32)60,},.attach_typ=
e =3D (__u32)2805058140,.attach_flags =3D (__u32)32767,.replace_bpf_fd =3D =
(__u32)1994993664,(union){.relative_fd =3D (__u32)32622,.relative_id =3D (_=
_u32)32622,},},.test =3D (struct){.prog_fd =3D (__u32)60,.data_size_in =3D =
(__u32)2805058140,.data_size_out =3D (__u32)32767,.data_in =3D (__u64)14011=
2418123776,.repeat =3D (__u32)7379400,.) =3D 0
>=20
>  16349.594 ( 0.002 ms): perf/1374043 bpf(cmd: MAP_FREEZE, uattr: (union b=
pf_attr){(struct){.map_type =3D (__u32)60,.value_size =3D (__u32)2805058140=
,.max_entries =3D (__u32)32767,.map_flags =3D (__u32)1994993664,.inner_map_=
fd =3D (__u32)32622,.map_ifindex =3D (__u32)2,.btf_fd =3D (__u32)2805058000=
,.btf_key_type_id =3D (__u32)32767,.btf_value_type_id =3D (__u32)16,.btf_vm=
linux_value_type_id =3D (__u32)48,.map_extra =3D (__u64)140735998446240,.va=
lue_type_btf_obj_fd =3D (__s32)-1489909280,.map_token_fd =3D (__s32)32767,}=
,(struct){.map_fd =3D (__u32)60,.key =3D (__u64)140735998446172,(union){.va=
lue =3D (__u64)140112418123776,.next_key =3D (__u64)140112418123776,},},.ba=
tch =3D (struct){.in_batch =3D (__u64)60,.out_batch =3D (__u64)140735998446=
172,.keys =3D (__u64)140112418123776,.count =3D (__u32)7379400,.elem_flags =
=3D (__u64)9110741168,.flags =3D (__u64)140735998446032,},(struct){.prog_ty=
pe =3D (__u32)60,.insns =3D (__u64)140735998446172,.license =3D (__u64)1401=
12418123776,.log_buf =3D (__u64)7379400,.kern_version =3D (__u32)520806576,=
=2Eprog_flags =3D (__u32)2,.prog_name =3D (char[16])[208,201,'1',167,255,12=
7,16,'0',],.prog_ifindex =3D (__u32)2805058208,.expected_attach_type =3D (_=
_u32)32767,.prog_btf_fd =3D (__u32)2805058016,.func_info_rec_size =3D (__u3=
2)32767,.func_info =3D (__u64)410826951296,.func_info_cnt =3D (__u32)487493=
0,.line_info =3D (__u64)40,.line_info_cnt =3D (__u32)1,.attach_btf_id =3D (=
__u32)4,(union){.attach_prog_fd =3D (__u32)520846144,.attach_btf_obj_fd =3D=
 (__u32)520846144,},.fd_array =3D (__u64)60,.core_relos =3D (__u64)14073599=
8445776,.core_relo_rec_size =3D (__u32)2805057752,.log_true_size =3D (__u32=
)524288,},(struct){.pathname =3D (__u64)60,.bpf_fd =3D (__u32)2805058140,.f=
ile_flags =3D (__u32)32767,.path_fd =3D (__s32)1994993664,},(struct){(union=
){.target_fd =3D (__u32)60,.target_ifindex =3D (__u32)60,},.attach_type =3D=
 (__u32)2805058140,.attach_flags =3D (__u32)32767,.replace_bpf_fd =3D (__u3=
2)1994993664,(union){.relative_fd =3D (__u32)32622,.relative_id =3D (__u32)=
32622,},},.test =3D (struct){.prog_fd =3D (__u32)60,.data_size_in =3D (__u3=
2)2805058140,.data_size_out =3D (__u32)32767,.data_in =3D (__u64)1401124181=
23776,.repeat =3D (__u32)7379400,.ctx_s) =3D 0
>  o
> 16349.601 ( 0.050 ms): perf/1374043 mmap(addr: 0x7f6e76e93000, len: 4096,=
 prot: READ, flags: SHARED|FIXED, fd: 60) =3D 0x7f6e76e93000
>=20
> root@x1:~# uname -a
> Linux x1 6.13.9-100.fc40.x86_64 #1 SMP PREEMPT_DYNAMIC Sat Mar 29 01:27:1=
8 UTC 2025 x86_64 GNU/Linux
> root@x1:~#
>=20
> root@x1:~# grep -m1 "model name" /proc/cpuinfo=20
> model name	: 13th Gen Intel(R) Core(TM) i7-1365U
> root@x1:~#=20

Well.. you don't need that on Intel and just use 'perf mem record'. :)

>=20
> Now trying on another machine:
>=20
> root@number:~# uname -a
> Linux number 6.15.0-rc4+ #2 SMP PREEMPT_DYNAMIC Tue Apr 29 15:56:43 -03 2=
025 x86_64 GNU/Linux
> root@number:~# grep -m1 "model name" /proc/cpuinfo
> model name	: AMD Ryzen 9 9950X3D 16-Core Processor
> root@number:~# perf record -aW --sample-mem-info -e cycles:P --filter 'me=
m_op =3D=3D load || mem_op =3D=3D store' sleep 1
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 1.870 MB perf.data (1199 samples) ]
> root@number:~#
>=20
> root@number:~# perf mem report -F overhead,dtlb,dso --stdio | head -20
> # To display the perf.data header info, please use --header/--header-only=
 options.
> #
> #
> # Total Lost Samples: 0
> #
> # Samples: 1K of event 'cycles:P'
> # Total weight : 7879
> # Sort order   : local_weight,mem,sym,dso,symbol_daddr,dso_daddr,snoop,tl=
b,locked,blocked,local_ins_lat,local_p_stage_cyc
> #
> #           ---------- D-TLB -----------                                 =
 =20
> # Overhead   L1-Hit L2-Hit   Miss  Other  Shared Object                  =
 =20
> # ........  ............................  ...............................=
=2E.
> #
>     48.51%    44.8%  18.7%  28.3%   8.2%  [kernel.kallsyms]              =
 =20
>     11.97%     2.1%   1.4%  96.0%   0.5%  libc.so.6                      =
 =20
>      8.58%    85.7%  14.1%   0.0%   0.3%  libxul.so                      =
 =20
>      6.76%   100.0%   0.0%   0.0%   0.0%  libfreeblpriv3.so              =
 =20
>      6.08%   100.0%   0.0%   0.0%   0.0%  libsystemd-shared-257.5-2.fc42.=
so
>      4.59%   100.0%   0.0%   0.0%   0.0%  firefox                        =
 =20
>      4.33%   100.0%   0.0%   0.0%   0.0%  libgallium-25.0.4.so           =
 =20
> root@number:~#
>=20
> Looks better :-)
>=20
> Having the record as an alias seems interesting, ditto for the report.

Yep, you can update 'perf mem record'.

Thanks,
Namhyung


