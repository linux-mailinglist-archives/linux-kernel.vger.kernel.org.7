Return-Path: <linux-kernel+bounces-819892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50898B7CA0E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FF0C16C5B1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 02:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28E02222AA;
	Wed, 17 Sep 2025 02:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SgeB0ro/"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884E7101F2
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758076674; cv=none; b=g4gJzkpNHzRK/nguksOhjhoyIb1omwFJ2BM/l2xOLUtGguMVNeFtdWiLLnuZjpSWgXgMRz4wUBw5ZLAT8OVkZj3j9OUZwFJ5kvXi/e1sWssK/aE4mE1+++nOEoJZAxTllH9s3iev31ZPvipowRCpublFbrapM9WZa5BUr4Mt3Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758076674; c=relaxed/simple;
	bh=+Oqv1htTU1oUQjoIW05xzrckf/ASgORwl3N7cCZXE1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gvexAaSJ6ox3ByiEwviLT2Z5bg9pfBF9BccH/p2R1VkR/ehW326OMs++Shr0eOV3jet24QLRjwoCqHw9A/RswSEcK3BhdVhBjaD0DwapC0r3+0UAfIWcdtvbzlveASvxqtgEompnIqvIflaAcdFbpMKNRhoNwXHEbF+UnisDfv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SgeB0ro/; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b8d641d6-9afc-4bfe-bf50-25ac4a3702a1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758076668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p3MY+R4WlGn4rtSW55R1LJoHIL+0MIVP772CgyYCMxU=;
	b=SgeB0ro/uuX3tDAlrYKbDux+d4sXbPUojiloZ7f+4R1MxgMa6Dk0dhrp62MhLOYXFKrWgw
	LO50glCVjyagbyRBpecTHT8TSQimV9YRjUL96CU5JFGSBHnoc8QnAO+6EtbUCoTlaq3Pkn
	bArAlUljAap/rTfb4Z1g0eTOWkC9kM8=
Date: Wed, 17 Sep 2025 10:37:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] bpftool: Fix UAF in get_delegate_value
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <20250916054111.1151487-1-chen.dylane@linux.dev>
 <20250916054111.1151487-2-chen.dylane@linux.dev>
 <CAADnVQKfH6QnLHfsGO_sL10LhTjL+YUWDist2+xGM_PiPjM9Wg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAADnVQKfH6QnLHfsGO_sL10LhTjL+YUWDist2+xGM_PiPjM9Wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/9/17 01:07, Alexei Starovoitov 写道:
> On Mon, Sep 15, 2025 at 10:42 PM Tao Chen <chen.dylane@linux.dev> wrote:
>>
>> The return value ret pointer is pointing opts_copy, but opts_copy
>> gets freed in get_delegate_value before return, fix this by strdup
>> a new buffer.
>>
>> Fixes: 2d812311c2b2 ("bpftool: Add bpf_token show")
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   tools/bpf/bpftool/token.c | 47 ++++++++++++++++++++++-----------------
>>   1 file changed, 27 insertions(+), 20 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/token.c b/tools/bpf/bpftool/token.c
>> index 82b829e44c8..c47256d8038 100644
>> --- a/tools/bpf/bpftool/token.c
>> +++ b/tools/bpf/bpftool/token.c
>> @@ -28,6 +28,12 @@ static bool has_delegate_options(const char *mnt_ops)
>>                 strstr(mnt_ops, "delegate_attachs");
>>   }
>>
>> +static void free_delegate_value(char *value)
>> +{
>> +       if (value)
>> +               free(value);
>> +}
>> +
>>   static char *get_delegate_value(const char *opts, const char *key)
>>   {
>>          char *token, *rest, *ret = NULL;
>> @@ -40,7 +46,7 @@ static char *get_delegate_value(const char *opts, const char *key)
>>                          token = strtok_r(NULL, ",", &rest)) {
>>                  if (strncmp(token, key, strlen(key)) == 0 &&
>>                      token[strlen(key)] == '=') {
>> -                       ret = token + strlen(key) + 1;
>> +                       ret = strdup(token + strlen(key) + 1);
> 
> Instead of adding more strdup-s
> strdup(mntent->mnt_opts) once per cmd/map/prog and
> remove another strdrup/free in print_items_per_line().
> 
> pw-bot: cr

will remove it in v2, thanks.

-- 
Best Regards
Tao Chen

