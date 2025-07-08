Return-Path: <linux-kernel+bounces-721661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 897F7AFCC1E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 930B11BC578E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDDE2DECA5;
	Tue,  8 Jul 2025 13:27:37 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C02D2DEA9F
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 13:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751981257; cv=none; b=sgFMAhRjZduCRwk0LP5Pvcl7lZNsp0dLI3hL9lRnJ1APqPmJUw99nc3BblsW7eRXI2mgBOjQaTvagRd5ZD3fxe6lF7c9B5/zdzAggOM21TmQtLauvw8ZVcSuhmeIRS8xMZVQlf6FqzGJxvgTjn/dLU6odqubS9TJ7sWrmXBAYyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751981257; c=relaxed/simple;
	bh=s0rJf/uo/x38H2D37T8w4TScfIzve0/xM4IgaapSnjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NNp8q8fm31bt3lR6TVf3NxnWrO2pNMHCrXFbjDfY6gs3cNW/8m7fMByu4vNXSlXI2wimhE7FhQLPqM/qtqxnm4xbd3DXjZF+YBtKo0cfaNXGBp2zBflSzl5CTcCqxDTiVMwX5Hm1t7V1JGl8U12nmNbJcuurcyQGaZCBlNKUuXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 27AF2441C0;
	Tue,  8 Jul 2025 13:27:23 +0000 (UTC)
Message-ID: <9bf5fc76-4bb2-4baf-88fe-e593b451f0ff@ghiti.fr>
Date: Tue, 8 Jul 2025 15:27:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] riscv: kprobes: Clean up instruction simulation
To: Nam Cao <namcao@linutronix.de>, patchwork-bot+linux-riscv@kernel.org
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org
References: <cover.1747215274.git.namcao@linutronix.de>
 <174904758698.2309006.9940004806769596353.git-patchwork-notify@kernel.org>
 <20250708102537.VovauOQC@linutronix.de>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250708102537.VovauOQC@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgeektdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnhepteetuddtkeffiefgjeffffefgfekffefteffgfffveffleeiieeufffffefhtddunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmpdhinhhfrhgruggvrggurdhorhhgnecukfhppedukeehrddvudefrdduheegrddugeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudekhedrvddufedrudehgedrudegfedphhgvlhhopegluddtrddugedrtddruddungdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeejpdhrtghpthhtohepnhgrmhgtrghosehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepphgrthgthhifohhrkhdqsghothdolhhinhhugidqrhhishgtvheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehprghul
 hdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopegrohhusegvvggtshdrsggvrhhkvghlvgihrdgvughupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: alex@ghiti.fr

Hi Nam,

On 7/8/25 12:25, Nam Cao wrote:
> On Wed, Jun 04, 2025 at 02:33:06PM +0000, patchwork-bot+linux-riscv@kernel.org wrote:
>> Hello:
>>
>> This series was applied to riscv/linux.git (for-next)
>> by Alexandre Ghiti <alexghiti@rivosinc.com>:
>>
>> On Wed, 14 May 2025 11:38:39 +0200 you wrote:
>>> Hi,
>>>
>>> There is some instruction-processing code in kprobes simulate code. These
>>> code should be insn.h. In fact, most of them is duplicating insn.h.
>>>
>>> This series remove the duplicated bits and make use of macros already
>>> defined in insn.h. The non-duplicated bits are moved into insn.h.
>>>
>>> [...]
>> Here is the summary with links:
>>    - [v2,01/11] riscv: kprobes: Move branch_rs2_idx to insn.h
>>      https://git.kernel.org/riscv/c/d29656bab74c
>>    - [v2,02/11] riscv: kprobes: Move branch_funct3 to insn.h
>>      https://git.kernel.org/riscv/c/da6de46c2eed
>>    - [v2,03/11] riscv: kprobes: Remove duplication of RV_EXTRACT_JTYPE_IMM
>>      https://git.kernel.org/riscv/c/6d47d903b18f
>>    - [v2,04/11] riscv: kprobes: Remove duplication of RV_EXTRACT_RS1_REG
>>      https://git.kernel.org/riscv/c/5cefc323f32a
>>    - [v2,05/11] riscv: kprobes: Remove duplication of RV_EXTRACT_BTYPE_IMM
>>      https://git.kernel.org/riscv/c/a285674909ae
>>    - [v2,06/11] riscv: kproves: Remove duplication of RVC_EXTRACT_JTYPE_IMM
>>      https://git.kernel.org/riscv/c/c7196c136e29
>>    - [v2,07/11] riscv: kprobes: Remove duplication of RVC_EXTRACT_C2_RS1_REG
>>      https://git.kernel.org/riscv/c/768007ca3fe8
>>    - [v2,08/11] riscv: kprobes: Remove duplication of RVC_EXTRACT_BTYPE_IMM
>>      https://git.kernel.org/riscv/c/f2c715fff676
>>    - [v2,09/11] riscv: kprobes: Remove duplication of RV_EXTRACT_RD_REG
>>      https://git.kernel.org/riscv/c/284ca2a100de
>>    - [v2,10/11] riscv: kprobes: Remove duplication of RV_EXTRACT_UTYPE_IMM
>>      https://git.kernel.org/riscv/c/a60c2933ec74
>>    - [v2,11/11] riscv: kprobes: Remove duplication of RV_EXTRACT_ITYPE_IMM
>>      https://git.kernel.org/riscv/c/ee4c45f5cbeb
> This series was dropped from 6.16 due to conflict. Can it be re-applied? It
> applies cleanly to riscv/for-next.
>
> The same story for:
> https://lore.kernel.org/linux-riscv/174904758974.2309006.8809303189389627595.git-patchwork-notify@kernel.org/


Yes, I have both in my for-next branch, sorry I did not advertise that 
(I'm working on it).

FYI, I have enabled kunit tests in the upstream kernel CI: 
https://github.com/linux-riscv/linux/actions/runs/15967114709/job/45030410210?pr=571#step:5:625

Thanks,

Alex


>
> Best regards,
> Nam
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

