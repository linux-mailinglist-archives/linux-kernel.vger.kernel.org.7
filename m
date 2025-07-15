Return-Path: <linux-kernel+bounces-731758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A8EB05918
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36DAA4A1AA0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09612D0C75;
	Tue, 15 Jul 2025 11:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m9fdLdad"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9D6252906
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 11:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752580055; cv=none; b=qAbEQq8ftw5nK7WA6g9x3b8pHw5DxalP6US6ycTg2J4f2vYPPg0nQhV6trQSHNVFjKqFPPiUOmWzdT9gjeUl0fntG/mrvXZfmAn0dC7t0Rsrv4D/XMmzrBV30bIsflGXKXtnLNAYEVsM2FSls7zzMFwYTGKblJ2tza5JwX+mxQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752580055; c=relaxed/simple;
	bh=yHaaynB8oqH4s1RD1xaBnb3JDiNTCzs4s7/O0aKzib4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LOke60c65VyTuyFs8Y9E5RwNgGruqKrq2Nd4T5M5kUUPstZD9M+Ig75f2tn1Sg2ve0PHWfo7EWKynAvZRCWDHdMJZZ0DX8RAUJV45xcj/cQv1vSdmfOyaD5YbHKLh45C+8dyLG4+JiNgUE4RCiYAMmc7s5lAwBsq5kCyl/kwsP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m9fdLdad; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae223591067so927968766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 04:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752580051; x=1753184851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJvOv3iC8J0K2u+8XocYvxToXukeLeYZU2F/qIP8yt0=;
        b=m9fdLdadYoTNrmQS5d2bgbII3TicytkLUvdinWO6E2TJJMdza51miodaGfvmdHAfoL
         HGPNLBy//nm8zQo+Af8Fvu5kPrqKQ/F9zaEDDP3vLRxC1i6mkyfHE+FprCJXzZrtzLGq
         3P08RZNQ5g0RvLqOajFBVANLvtuK4Vyx5jx819shXr4JFU6+MH5fiQ+1fhvf54yGIzqv
         u4JgETj6su/FTIpZz3ir3Vj+yLWWz/8WUb7mMwICMTg808eUvmLHa2NJfUM/VUg1keyB
         TE/npJjMZS0wuWyDvuwVT/glN8bdgD9jNfxxxIxo2s/zVjvt5WaofdM6LiTUJj4ATSnq
         kxJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752580051; x=1753184851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJvOv3iC8J0K2u+8XocYvxToXukeLeYZU2F/qIP8yt0=;
        b=OmbhdT2gxDzKVtw+xsaib+yAzcwZg91IlTLxZZuAYjvzCbWBng+9+zctqKUOWpGdfX
         TDPQ+XCJFcbcFqoXTiURx6CMnNTJGR6e2sKKQyAJtj89Um5FMOivVpsmQAbCpkGAVg97
         tKJRFZC/jgWDJXPy7uKSfDEyAQ8ApBXNmkt3aTNm8Asij7kXUQEIq4N7ymJlTxkGoMQy
         2xev5+YIiuinBs9+yF3rkayOkDxUHuqRFsJ41BSs3LCz659YOd4KCpM9YqWttP9X6Vag
         CEY6cSR6fPa6PxIHfO/uYgIZ33qkeVJyGFaJ9bH9GkVHApcrGg/0eRFQ1s5Qs4UMmK1p
         A+pw==
X-Forwarded-Encrypted: i=1; AJvYcCUxV/mlVa8P+D6K89FcutjJbRTRY9JgdTRNuK7KNE3F2yL96sftsEe/aioqq9ovXq/GzEpwP4XUDlLiZc0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs6HrHgwvT6On4VBwdbmNlCpq+7pgt8jZwgQUnP9xrxhUQmbx7
	jfIhrb8Bs/fe2qeGUUVdV+XPuu2Xm3IXW6isyi/aZUYRj8OKThTnmZHj+JiX1GGsnJdJtaw9zcQ
	bG3KwzJrGKG22V6XkGIGDyh36/CL/snEKEPnZbplM
X-Gm-Gg: ASbGnctr7/j4z0FUtDo6vihI920rcfDcT2IuqzjkOoN4C9AfxRsr6PTCbJ9HeOY7vKs
	jCtRyAComMq/eqdgG11zS2bXUJehP3wI3wNfGOjnoIrG5gLUTC+6Tlpd6UNbwYkhrxLeE5Em0Tu
	TRN2KlKrNeIacufuiRVKIg0ucg5bjyBgGo8hm0NU8b84UMP3pDv951WLjkdg5rdIvJukIouNJFh
	A/aRnXOJAtxJjYMPq9AG2HRUYTXVjLV+HKXvLDiaZeW1aHe
X-Google-Smtp-Source: AGHT+IERHtiT8i1MYCr6EUL+SQLpDG5er/ubJ4ykdR4RAvST5au0QfdrvR0mHbAVZKaxtOuDwBcjuu7BF0+dB9RrOh0=
X-Received: by 2002:a17:907:3d43:b0:ae0:a88e:6f20 with SMTP id
 a640c23a62f3a-ae6fbe7e2cemr1751024666b.15.1752580051000; Tue, 15 Jul 2025
 04:47:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752013061.git.babu.moger@amd.com> <d55fea7bdb5df1e39de59b23289197ace08020b8.1752013061.git.babu.moger@amd.com>
In-Reply-To: <d55fea7bdb5df1e39de59b23289197ace08020b8.1752013061.git.babu.moger@amd.com>
From: Peter Newman <peternewman@google.com>
Date: Tue, 15 Jul 2025 13:47:20 +0200
X-Gm-Features: Ac12FXyvWUuxdrhu_-0M3JaoedyZQtTdtEb61dEMZnOq_NVPoE1izoyVMIb3XaY
Message-ID: <CALPaoCgt=fk8-pOunx7EiR3ESLV2EWCBxpo3My2q7Nz8uXfz-g@mail.gmail.com>
Subject: Re: [PATCH v15 05/34] x86/cpufeatures: Add support for Assignable
 Bandwidth Monitoring Counters (ABMC)
To: Babu Moger <babu.moger@amd.com>
Cc: corbet@lwn.net, tony.luck@intel.com, reinette.chatre@intel.com, 
	james.morse@arm.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, Dave.Martin@arm.com, x86@kernel.org, 
	hpa@zytor.com, akpm@linux-foundation.org, paulmck@kernel.org, 
	rostedt@goodmis.org, Neeraj.Upadhyay@amd.com, david@redhat.com, arnd@arndb.de, 
	fvdl@google.com, seanjc@google.com, jpoimboe@kernel.org, 
	pawan.kumar.gupta@linux.intel.com, xin@zytor.com, manali.shukla@amd.com, 
	tao1.su@linux.intel.com, sohil.mehta@intel.com, kai.huang@intel.com, 
	xiaoyao.li@intel.com, peterz@infradead.org, xin3.li@intel.com, 
	kan.liang@linux.intel.com, mario.limonciello@amd.com, thomas.lendacky@amd.com, 
	perry.yuan@amd.com, gautham.shenoy@amd.com, chang.seok.bae@intel.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Babu,

On Wed, Jul 9, 2025 at 12:18=E2=80=AFAM Babu Moger <babu.moger@amd.com> wro=
te:
>
> Users can create as many monitor groups as RMIDs supported by the hardwar=
e.
> However, bandwidth monitoring feature on AMD system only guarantees that
> RMIDs currently assigned to a processor will be tracked by hardware. The
> counters of any other RMIDs which are no longer being tracked will be res=
et
> to zero. The MBM event counters return "Unavailable" for the RMIDs that a=
re
> not tracked by hardware. So, there can be only limited number of groups
> that can give guaranteed monitoring numbers. With ever changing
> configurations there is no way to definitely know which of these groups a=
re
> being tracked during a particular time. Users do not have the option to
> monitor a group or set of groups for a certain period of time without
> worrying about RMID being reset in between.
>
> The ABMC feature allows users to assign a hardware counter to an RMID,
> event pair and monitor bandwidth usage as long as it is assigned. The
> hardware continues to track the assigned counter until it is explicitly
> unassigned by the user. There is no need to worry about counters being
> reset during this period. Additionally, the user can specify the type of
> memory transactions (e.g., reads, writes) for the counter to track.
>
> Without ABMC enabled, monitoring will work in current mode without
> assignment option.
>
> The Linux resctrl subsystem provides an interface that allows monitoring =
of
> up to two memory bandwidth events per group, selected from a combination =
of
> available total and local events. When ABMC is enabled, two events will b=
e
> assigned to each group by default, in line with the current interface
> design. Users will also have the option to configure which types of memor=
y
> transactions are counted by these events.
>
> Due to the limited number of available counters (32), users may quickly
> exhaust the available counters. If the system runs out of assignable ABMC
> counters, the kernel will report an error. In such cases, users will need
> to unassign one or more active counters to free up counters for new
> assignments. resctrl will provide options to assign or unassign events
> through the group-specific interface file.
>
> The feature is detected via CPUID_Fn80000020_EBX_x00 bit 5.
> Bits Description
> 5    ABMC (Assignable Bandwidth Monitoring Counters)
>
> The feature details are documented in APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
> Monitoring (ABMC).
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> Note: Checkpatch checks/warnings are ignored to maintain coding style.
>
> v15: Minor changelog update.
>
> v14: Removed the dependancy on X86_FEATURE_CQM_MBM_TOTAL and X86_FEATURE_=
CQM_MBM_LOCAL.
>      as discussed in https://lore.kernel.org/lkml/5f8b21c6-5166-46a6-be14=
-0c7c9bfb7cde@intel.com/
>      Need to re-work on ABMC enumeration during the init.
>      Updated changelog with few text update.
>
> v13: Updated the commit log with Linux interface details.
>
> v12: Removed the dependancy on X86_FEATURE_BMEC.
>      Removed the Reviewed-by tag as patch has changed.
>
> v11: No changes.
>
> v10: No changes.
>
> v9: Took care of couple of minor merge conflicts. No other changes.
>
> v8: No changes.
>
> v7: Removed "" from feature flags. Not required anymore.
>     https://lore.kernel.org/lkml/20240817145058.GCZsC40neU4wkPXeVR@fat_cr=
ate.local/
>
> v6: Added Reinette's Reviewed-by. Moved the Checkpatch note below ---.
>
> v5: Minor rebase change and subject line update.
>
> v4: Changes because of rebase. Feature word 21 has few more additions now=
.
>     Changed the text to "tracked by hardware" instead of active.
>
> v3: Change because of rebase. Actual patch did not change.
>
> v2: Added dependency on X86_FEATURE_BMEC.
> ---
>  arch/x86/include/asm/cpufeatures.h | 1 +
>  arch/x86/kernel/cpu/scattered.c    | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cp=
ufeatures.h
> index b78af55aa22e..d2950a0177cd 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -490,6 +490,7 @@
>  #define X86_FEATURE_PREFER_YMM         (21*32+ 8) /* Avoid ZMM registers=
 due to downclocking */
>  #define X86_FEATURE_APX                        (21*32+ 9) /* Advanced Pe=
rformance Extensions */
>  #define X86_FEATURE_INDIRECT_THUNK_ITS (21*32+10) /* Use thunk for indir=
ect branches in lower half of cacheline */
> +#define X86_FEATURE_ABMC               (21*32+11) /* Assignable Bandwidt=
h Monitoring Counters */

It looks like this bit has been taken by X86_FEATURE_TSA_SQ_NO. I had
to move X86_FEATURE_ABMC down to (21*32+14) on tip/master.

Thanks,
-Peter

>
>  /*
>   * BUG word(s)
> diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scatte=
red.c
> index dbf6d71bdf18..d5d4a573aaf7 100644
> --- a/arch/x86/kernel/cpu/scattered.c
> +++ b/arch/x86/kernel/cpu/scattered.c
> @@ -50,6 +50,7 @@ static const struct cpuid_bit cpuid_bits[] =3D {
>         { X86_FEATURE_MBA,                      CPUID_EBX,  6, 0x80000008=
, 0 },
>         { X86_FEATURE_SMBA,                     CPUID_EBX,  2, 0x80000020=
, 0 },
>         { X86_FEATURE_BMEC,                     CPUID_EBX,  3, 0x80000020=
, 0 },
> +       { X86_FEATURE_ABMC,                     CPUID_EBX,  5, 0x80000020=
, 0 },
>         { X86_FEATURE_AMD_WORKLOAD_CLASS,       CPUID_EAX, 22, 0x80000021=
, 0 },
>         { X86_FEATURE_PERFMON_V2,               CPUID_EAX,  0, 0x80000022=
, 0 },
>         { X86_FEATURE_AMD_LBR_V2,               CPUID_EAX,  1, 0x80000022=
, 0 },
> --
> 2.34.1
>

