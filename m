Return-Path: <linux-kernel+bounces-776659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7ADB2CFFF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C66F3A179F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A0626E701;
	Tue, 19 Aug 2025 23:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LTRdl8Q8"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8061021A459
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755646320; cv=none; b=EdRdVfkmqLy3h7nR9nDo1Gpl0EZL1/945asT522NyhnWijD6cc2E2hwJOzjbHO9qU/rZVIWBT8XUEl9fA3pRitpIhgKstdsiul7OOP5RaqucbZTUtPBEoocJx9Pk3n2IrSJUHkUghwrp8Yw8r47z/gxp1hZ71146pnIgyg6dW6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755646320; c=relaxed/simple;
	bh=rA9wv+pWnx1zpBDWKfX6eyU3H5xcCfx6wo8nlwToeOA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fH7qIAXpg4e0ZadMmpuM+jdieT02pgjN6f4d7lCiwsdTRzzOZ0Fbx092Rn0e1mOKqpH5s/7drTj0mHKsT4pDsYPWWhPVW2o/TfYUcgtnBWhwqP4cMqA5mNukA+QeE1TqWMhB42twiqpHnqwjAJpVeMTL1i7flTFZXSuM+Vk6bZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LTRdl8Q8; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755646315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gTcaclbQ96B+bDuBdiEL8ARlJKH5hHL3AxN4AB69H20=;
	b=LTRdl8Q8BJzAwYcj49uLQDdPuiA4IbEhrwThhy3zCP+J/PfKqPZxPiKjiXbPvT1KZYtAZD
	ZHryLZDWX1GYdOQAh9ymUnZudKtpRCEv9aeYuUCTdc+SWe+Z90XJSSdbQK7kVmg8OPjtBz
	cLwcYOtaXcz9h0M0vfYrwMunlb4GRUQ=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: linux-mm@kvack.org,  bpf@vger.kernel.org,  Johannes Weiner
 <hannes@cmpxchg.org>,  Michal Hocko <mhocko@suse.com>,  David Rientjes
 <rientjes@google.com>,  Matt Bobrowski <mattbobrowski@google.com>,  Song
 Liu <song@kernel.org>,  Kumar Kartikeya Dwivedi <memxor@gmail.com>,
  Alexei Starovoitov <ast@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 12/14] sched: psi: implement psi trigger handling
 using bpf
In-Reply-To: <87tt23vt8u.fsf@linux.dev> (Roman Gushchin's message of "Tue, 19
	Aug 2025 15:31:13 -0700")
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
	<20250818170136.209169-13-roman.gushchin@linux.dev>
	<CAJuCfpHUDSJ_yLEqtfmU0rykUGYM6tXR+rgVv1i3QjJz+2JU1A@mail.gmail.com>
	<87tt23vt8u.fsf@linux.dev>
Date: Tue, 19 Aug 2025 16:31:43 -0700
Message-ID: <87cy8qx50g.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Roman Gushchin <roman.gushchin@linux.dev> writes:

> Suren Baghdasaryan <surenb@google.com> writes:
>
>> On Mon, Aug 18, 2025 at 10:02=E2=80=AFAM Roman Gushchin
>> <roman.gushchin@linux.dev> wrote:
>
>>
>>> +
>>> +       /* Cgroup Id */
>>> +       u64 cgroup_id;
>>
>> This cgroup_id field is weird. It's not initialized and not used here,
>> then it gets initialized in the next patch and used in the last patch
>> from a selftest. This is quite confusing. Also logically I don't think
>> a cgroup attribute really belongs to psi_trigger... Can we at least
>> move it into bpf_psi where it might fit a bit better?
>
> I can't move it to bpf_psi, because a single bpf_psi might own multiple
> triggers with different cgroup_id's.
> For sure I can move it to the next patch, if it's preferred.
>
> If you really don't like it here, other option is to replace it with
> a new bpf helper (kfunc) which calculates the cgroup_id by walking the
> trigger->group->cgroup->cgroup_id path each time.

Actually there is no easy path from psi_group to cgroup, so there is
no such option available, unfortunately. Or we need a back-link from
the psi_group to cgroup.

