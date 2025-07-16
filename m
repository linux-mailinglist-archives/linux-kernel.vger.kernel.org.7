Return-Path: <linux-kernel+bounces-733822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8435B07966
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A740D7AFF18
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079DD26D4D8;
	Wed, 16 Jul 2025 15:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="BhZtTmb7"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B3914F98
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679082; cv=none; b=ooR67D6qRRtRLfkE+XmQRkrAsJ3q7GwPkHiUNiafzCpxqxW9Cv4fwk9HCTSstIRWr4aG+7eOR3bqXw//W6mBMBJdf4K+mQgDyTZYnrCcvSskjHyoHx2ocKpgUl1RS2mJTkveeBOvnfQ4QoQYJia/b1rVkJKpsXEZrFi0vDR7g5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679082; c=relaxed/simple;
	bh=UmKJT44q8B8tkOYqsIXVCEcob4pl4PUJEQSmsPyn+hk=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=VF2RK/YIeQSeytdRiAA08abTdzAR5jNmTJClgoSbucdlGemJBk5JVGS3rnA8ZoTvhadyd0OfvQeVpzZY1vUPboYUgCEimTk1r5zYgs5tZcxi9mASYg9RX9eVKg9fONDs1PbGLr+ZkAY2QLrU+G1CmIadMKDSKyP3xWKOFnHcECo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=BhZtTmb7; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b26f7d2c1f1so7743305a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1752679079; x=1753283879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nIjarP2qmIxEUNr1tc1uUPfdZWXV9rUJNqLMiF74jXY=;
        b=BhZtTmb7sjbxnXaIm6+c4QF0N91mOJroQHgF66JyOsI05onDPmp4pc7iS5Szl7qQwV
         MEopJ5BJ7Z+jhY2NqjiyP+P950YnBunfAQUvf3SIP5b76ZIYIDVEx+4vDyjHhZtAJ3Qr
         SnkBN3mO6ljwcPQ60U5LfKUxLNZD4Raw3Asa3WGhhI15J9m+Hwvj7D3nD7a3Vkc5I+xZ
         Fk2cUBs+7ysWvQ1FR0tfdGpk+f0FiutZrsGJqiAcEsz6lfp9fFaDS2JQHCBsk6BCVopb
         L9g+IwzwiduPToH6rjHWeSVFh9CXBkLecy7gymXCyin9pnfwlkbNGTCSCqk4I/2SJZCI
         opPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752679079; x=1753283879;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIjarP2qmIxEUNr1tc1uUPfdZWXV9rUJNqLMiF74jXY=;
        b=GEGVSLUO/o/LIIfD7TbD9KmtamNLuixHq9Da4Yvu+3ckizQW8u/HU6UKzSP8OrMWJq
         mCGsbtSDWI3ZXGO4MG1yQkRIYmRhdRWVvqVgYCDQNSb4xkqU4VSdrcZ4CBJTVjjNE4ba
         Lk3tqmErJ9A12sNkBmZvR8P/007mhWKpzdUmAop1KjjH6tN8LosbwVsIuubIiw8R7RnT
         geEjH0B2K9MytKm8VdDcjjHfoW/dmvF/wFFMPbaSYkIXlqa+wGjcfFF/hbSQAZjCcax9
         yQgYglfLHIzdlVuIcQhuHbveGSUpGVGKbIpYzkcLMZc0BGmPxLPz//ihiYDPDQH+41I4
         cotg==
X-Forwarded-Encrypted: i=1; AJvYcCVzGA5estDpPBOSZ8W0ZksI57wY7UUeikuYiWIqnKNuNV3mJuOjsybswqRON54PXeFWx9OdSjQuWvsGZqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBi35gc9vuO0sd29IocjAXYnaYRxQXKRbmAyJ/znBNAXIgoCNx
	xNU+88olAnARa6+0ZRvuWIVPx9d38iknsBfwbT1kGqO/5cng88NcFyjAvE6qM+JkI00=
X-Gm-Gg: ASbGncvZoJ1bOAMK77XkDBRVfMJORoRUwiUs9NMXJ5H+VWIvt/3Xlwty3pICum5EFng
	s2wRK06LBfZ+2yUlVZb92Kmwpfb1exsz2yQvSEvoqCuMihE2K6PZtspnzU1QS7ioJ/RvePwNrZa
	ASZ9VvyYruMbWDA7SjuA/OlMv7P7M4XhvEBUvUmAfrKGinwEQu1IBOzAUB1EzcJ3jkM4IN1C/5N
	tV/pzAcpCWCt6hBt0R2X8IVEW2a8nfeLsXva81MZVaeJJxLqPp9RL1W2vKUW/wAjU+Ij8C9EUsU
	qAOsusO6qpsnu1NqlVO7Ifu1GC8btrJuqBm7LWLNLaXODVh9Eb3MgRlZtTNFjawSbSQKQQEaocP
	t/QzlSNe4LMpodXVl+erG
X-Google-Smtp-Source: AGHT+IGQvipCL8I7Jp/o0kQbtdNtCpkDRd45ElcLm4C7rqFsQkVF1I178icC+V6YopeF2v7qVU9sWg==
X-Received: by 2002:a17:90b:2684:b0:311:ff18:b84b with SMTP id 98e67ed59e1d1-31c9f47c7d7mr4052918a91.25.1752679079182;
        Wed, 16 Jul 2025 08:17:59 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::4:b02a])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23de4323cd5sm127190795ad.126.2025.07.16.08.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:17:58 -0700 (PDT)
Date: Wed, 16 Jul 2025 08:17:58 -0700 (PDT)
X-Google-Original-Date: Wed, 16 Jul 2025 08:17:56 PDT (-0700)
Subject:     Re: [PATCH] riscv: Stop considering R_RISCV_NONE as bad relocations
In-Reply-To: <20250711134909.GA73430@iscas.ac.cn>
CC: alexghiti@rivosinc.com, alexghiti@rivosinc.com, Nelson Chu <nelson@rivosinc.com>,
  Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, Alexandre Ghiti <alex@ghiti.fr>,
  linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: wangjingwei@iscas.ac.cn
Message-ID: <mhng-4C27A130-61EA-4AA5-A2A6-506D0CB22B7B@palmerdabbelt-mac>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Fri, 11 Jul 2025 06:49:09 PDT (-0700), wangjingwei@iscas.ac.cn wrote:
> Hi all,
>
> On Thu, Jul 10, 2025 at 11:43:00AM -0700, Palmer Dabbelt wrote:
>> On Thu, 10 Jul 2025 01:34:31 PDT (-0700), alexghiti@rivosinc.com wrote:
>> > Even though those relocations should not be present in the final
>> > vmlinux, there are a lot of them. And since those relocations are
>> > considered "bad", they flood the compilation output which may hide some
>> > legitimate bad relocations.
>> >
>> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> > ---
>> >  arch/riscv/tools/relocs_check.sh | 4 +++-
>> >  1 file changed, 3 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/arch/riscv/tools/relocs_check.sh b/arch/riscv/tools/relocs_check.sh
>> > index baeb2e7b2290558d696afbc5429d6a3c69ae49e1..742993e6a8cba72c657dd2f8f5dabc4c415e84bd 100755
>> > --- a/arch/riscv/tools/relocs_check.sh
>> > +++ b/arch/riscv/tools/relocs_check.sh
>> > @@ -14,7 +14,9 @@ bad_relocs=$(
>> >  ${srctree}/scripts/relocs_check.sh "$@" |
>> >  	# These relocations are okay
>> >  	#	R_RISCV_RELATIVE
>> > -	grep -F -w -v 'R_RISCV_RELATIVE'
>> > +	#	R_RISCV_NONE
>> > +	grep -F -w -v 'R_RISCV_RELATIVE
>> > +R_RISCV_NONE'
>> >  )
>>
>> I'm not super opposed to it, but is there a way to just warn once or
>> something?  It's probably best to still report something, as there's likely
>> some sort of toolchain issue here.
>>
>
> I think Alexandre's approach is ideal from the kernel's perspective.
> This doesn't really seem to be a bug; I see it more as a case where the
> toolchain's handling of R_RISCV_NONE doesn't quite match the kernel's
> expectations.
>
> I found the large number of R_RISCV_NONE relocs only appear in the final
> vmlinux. The key difference is the kernel build's --emit-relocs flag
> and the *(.rela.text*) directive in vmlinux.lds.S. This combination
> forces all relocation entries, including those marked as R_RISCV_NONE,
> to be written verbatim into the final vmlinux.

Ah, OK, if it's coming from "--emit-relocs" then actually it seems fine.  
So I think this is the right way to go, then.  It's on fixes, should 
show up for Linus later this week.

> I traced this back to BFD's implementation and found that during
> relaxation (e.g., when an auipc+jalr is optimized to a jal), the linker
> modifies the first reloc slot to R_RISCV_JAL and marks the second,
> now-useless slot as R_RISCV_DELETE. In the cleanup phase, to prevent
> reprocessing, BFD then changes the cleaned-up DELETE marker to
> R_RISCV_NONE. This is how, when the kernel specifies --emit-relocs,
> these R_RISCV_NONE markers get preserved in the final .rela.text section.
>
> To truly change this, it seems to depend on whether the binutils
> is willing to add a stage to clean up these harmless but
> useless markers.
>
> If possible, I was thinking we could perhaps iterate and remove the
> R_RISCV_NONE entries from .rela.text before the alignment pass.
>
> But if there's no agreement on the BFD side, Alexandre's approach still
> seems correct and aligns with the psABI, where R_RISCV_NONE has no
> operational meaning.
>
>> Also: if you can reproduce it, Nelson can probably fix it.  I'm CCing him.
>>
>
> Reproducing the issue is simple: you just need a call instruction to
> create a relaxation opportunity, then link with --emit-relocs and a
> linker script that includes *(.rela.text*). :)
>
> For convenience, I've put a minimal, self-contained reproduction case
> here: https://gist.github.com/Jingwiw/762606e1dc3b77c352b394e8c5e846de
>
>> >
>> >  if [ -z "$bad_relocs" ]; then
>>
>
> Reviewed-by: Jingwei Wang <wangjingwei@iscas.ac.cn>
>
> Thanks,
> Jingwei

