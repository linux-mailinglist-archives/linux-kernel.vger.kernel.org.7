Return-Path: <linux-kernel+bounces-747352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDC7B132DD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 04:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FB211755F2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 02:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C317C199931;
	Mon, 28 Jul 2025 02:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ukCT9c4m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D462E62C
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 02:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753668177; cv=none; b=rpVpaoYKU/P9ApMvt8tUwIv14rk3dNy31qIqb7vmCw4V5avM3vlM9ovBI4PAFURU54kkzCfKEjEv6P6lgBUSdS0CaDM2N0aRTRlmOAkrBi7p21BY+x1DHvhcTnq8MELv3u0RTzfbXbJ/sC+dUZKSEpDxruniv+yW1saRO+ygQSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753668177; c=relaxed/simple;
	bh=eUFaymsaMCqWC8SITEP0Zp2oqMjJbMviU+6OgCblgic=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CDdvT8omRtxYPJTCv78cmqtEE/rQdNFlulpWjzqUjhYlRDxwi8rO+FoQTXvKyl4ZJEdKZdWf3aMf8M29l+cGqm//VNecnvXIm0vpa6VjjqPURLRqn6fJUgV3pcyaeshHzTXKOUM2XxQe4Q3Ay5RxIl328ZZTbiQkkQ+7awpK1x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ukCT9c4m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A78C4CEEB;
	Mon, 28 Jul 2025 02:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753668176;
	bh=eUFaymsaMCqWC8SITEP0Zp2oqMjJbMviU+6OgCblgic=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=ukCT9c4mz/NIVKBEFZqHonl2Y+HRxSsmhbQ2vVXNbM9NPr/fR9lA7Lse3/mE1DOvA
	 HK31oBt2A6MtAbXVvmDjvO9lIyZxGW+045lRGHoWjBtJALxJjlkRhEmcCXSASQTe4l
	 dJg+k+mLCL/+rwQVRSNQl7gDY4Z3bS+Cygreog9vNCV3urKBg24esDZRyp9QfTYq7N
	 vU2gGkwYDz7or+ikcmrqcdLvlQLEtKjJsNpQA04A8X1rmyD/+EL3FWnYIZxkJpx1iq
	 L7UwCefLzlV+W+/SjkgOtUFbW7uzqzAzkv5FnPnVPltcxPJPBBX222CXBUea6Y406H
	 R1rg8Sicuuisg==
Message-ID: <a69c3687-fa00-41b6-861c-557ad1d83588@kernel.org>
Date: Mon, 28 Jul 2025 10:02:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v3] mkfs.f2fs: support -C [no]hashonly to
 control linear lookup fallback
To: Zhiguo Niu <niuzhiguo84@gmail.com>
References: <20250725054922.3972265-1-chao@kernel.org>
 <CAHJ8P3LBH7oxV8nOiwU3yfQSr+LmK58EvFtyF8YLPQ=usZpqFA@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CAHJ8P3LBH7oxV8nOiwU3yfQSr+LmK58EvFtyF8YLPQ=usZpqFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/28/25 09:05, Zhiguo Niu wrote:
> Hi Chao
> 
> Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
> 于2025年7月25日周五 13:51写道：
>>
>> It provides a way to disable linear lookup fallback during mkfs.
>>
>> Behavior summary:
>>                         Android         Distro
>> By default              disabled        enabled
>>
>> Android case:
>>
>> 1.1) Disable linear lookup:
>> - mkfs.f2fs -f -g android -O casefold -C utf8:hashonly /dev/vdb
>> - dump.f2fs -d3 /dev/vdb |grep s_encoding_flags
>> s_encoding_flags                        [0x       2 : 2]
>>
>> 1.2) Enable linear lookup:
>> - mkfs.f2fs -f -g android -O casefold -C utf8:nohashonly /dev/vdb
>> - dump.f2fs -d3 /dev/vdb |grep s_encoding_flags
>> s_encoding_flags                        [0x       0 : 0]
>>
>> 1.3) By default:
>> - mkfs.f2fs -f -g android -O casefold -C utf8 /dev/vdb
>> Info: set default linear_lookup option: disable
>> - dump.f2fs -d3 /dev/vdb |grep s_encoding_flags
>> s_encoding_flags                        [0x       2 : 2]
>>
>> Distro case:
>>
>> 2.1) Disable linear lookup:
>> - mkfs.f2fs -f -O casefold -C utf8:hashonly /dev/vdb
>> - dump.f2fs -d3 /dev/vdb |grep s_encoding_flags
>> s_encoding_flags                        [0x       2 : 2]
>>
>> 2.2) Enable linear lookup:
>> - mkfs.f2fs -f -O casefold -C utf8:nohashonly /dev/vdb
>> - dump.f2fs -d3 /dev/vdb |grep s_encoding_flags
>> s_encoding_flags                        [0x       0 : 0]
>>
>> 2.3) By default:
>> - mkfs.f2fs -f -O casefold -C utf8 /dev/vdb
>> - dump.f2fs -d3 /dev/vdb |grep s_encoding_flags
>> s_encoding_flags                        [0x       0 : 0]
>>
> It is very clear and easy to understand.
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>> v3:
>> - honor [no]hashonly flag for Android case
>> - update testcase and output
>>  include/f2fs_fs.h       |  3 ++-
>>  lib/libf2fs.c           |  6 ++++++
>>  man/mkfs.f2fs.8         |  9 ++++++++-
>>  mkfs/f2fs_format.c      | 11 +++++++++++
>>  mkfs/f2fs_format_main.c |  3 ++-
>>  5 files changed, 29 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
>> index f7268d1..a8da8fa 100644
>> --- a/include/f2fs_fs.h
>> +++ b/include/f2fs_fs.h
>> @@ -1478,7 +1478,8 @@ enum {
>>
>>  /* feature list in Android */
>>  enum {
>> -       F2FS_FEATURE_NAT_BITS = 0x0001,
>> +       F2FS_FEATURE_NAT_BITS           = 0x0001,
>> +       F2FS_FEATURE_LINEAR_LOOKUP      = 0x0002,
>>  };
>>
>>  /* nolinear lookup tune */
>> diff --git a/lib/libf2fs.c b/lib/libf2fs.c
>> index 2f012c8..1a496b7 100644
>> --- a/lib/libf2fs.c
>> +++ b/lib/libf2fs.c
>> @@ -1424,6 +1424,7 @@ static const struct enc_flags {
>>         char *param;
>>  } encoding_flags[] = {
>>         { F2FS_ENC_STRICT_MODE_FL, "strict" },
>> +       { F2FS_ENC_NO_COMPAT_FALLBACK_FL, "hashonly"}
>>  };
>>
>>  /* Return a positive number < 0xff indicating the encoding magic number
>> @@ -1485,6 +1486,11 @@ int f2fs_str2encoding_flags(char **param, __u16 *flags)
>>                                         *flags |= fl->flag;
>>                                 }
>>
>> +                               if (fl->flag == F2FS_ENC_NO_COMPAT_FALLBACK_FL)
>> +                                       c.nolinear_lookup = neg ?
>> +                                               LINEAR_LOOKUP_ENABLE :
>> +                                               LINEAR_LOOKUP_DISABLE;
>> +
>>                                 goto next_flag;
>>                         }
>>                 }
>> diff --git a/man/mkfs.f2fs.8 b/man/mkfs.f2fs.8
>> index 8b3b0cc..fcb227c 100644
>> --- a/man/mkfs.f2fs.8
>> +++ b/man/mkfs.f2fs.8
>> @@ -232,10 +232,17 @@ Use UTF-8 for casefolding.
>>  .I flags:
>>  .RS 1.2i
>>  .TP 1.2i
>> -.B strict
>> +.B [no]strict
>>  This flag specifies that invalid strings should be rejected by the filesystem.
>>  Default is disabled.
>>  .RE
>> +.RS 1.2i
>> +.TP 1.2i
>> +.B [no]hashonly
>> +This flag specifies that linear lookup fallback is off during lookup, to turn
>> +off linear lookup fallback, use nohashonly flag.
> here should "to turn off linear lookup fallback, use hashonly flag"?
> or "to turn on linear lookup fallback, use nohashonly flag"

Zhiguo,

Yes, it's typo, let me fix it, thanks for the review.

Thanks,

> 1.1) Disable linear lookup:
> - mkfs.f2fs -f -g android -O casefold -C utf8:hashonly /dev/vdb
> 
>> +For android case, it will disable linear lookup by default.
>> +.RE
>>  .RE
>>  .TP
>>  .BI \-q
>> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
>> index 2680bd3..04dfc20 100644
>> --- a/mkfs/f2fs_format.c
>> +++ b/mkfs/f2fs_format.c
>> @@ -671,6 +671,17 @@ static int f2fs_prepare_super_block(void)
>>         memcpy(sb->init_version, c.version, VERSION_LEN);
>>
>>         if (c.feature & F2FS_FEATURE_CASEFOLD) {
>> +               /*
>> +                * if [no]hashonly option is not assigned, let's disable
>> +                * linear lookup fallback by default for Android case.
>> +                */
>> +               if ((c.nolinear_lookup == LINEAR_LOOKUP_DEFAULT) &&
>> +                       (c.disabled_feature & F2FS_FEATURE_LINEAR_LOOKUP)) {
>> +                       c.s_encoding_flags |= F2FS_ENC_NO_COMPAT_FALLBACK_FL;
>> +                       MSG(0, "Info: set default linear_lookup option: %s\n",
>> +                               c.s_encoding_flags & F2FS_ENC_NO_COMPAT_FALLBACK_FL ?
>> +                               "disable" : "enable");
>> +               }
>>                 set_sb(s_encoding, c.s_encoding);
>>                 set_sb(s_encoding_flags, c.s_encoding_flags);
>>         }
>> diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
>> index f0bec4f..8f8e975 100644
>> --- a/mkfs/f2fs_format_main.c
>> +++ b/mkfs/f2fs_format_main.c
>> @@ -143,7 +143,8 @@ static void add_default_options(void)
>>                 force_overwrite = 1;
>>                 c.wanted_sector_size = F2FS_BLKSIZE;
>>                 c.root_uid = c.root_gid = 0;
>> -               c.disabled_feature |= F2FS_FEATURE_NAT_BITS;
>> +               c.disabled_feature |= F2FS_FEATURE_NAT_BITS |
>> +                                       F2FS_FEATURE_LINEAR_LOOKUP;
>>
>>                 /* RO doesn't need any other features */
>>                 if (c.feature & F2FS_FEATURE_RO)
> others look OK to me,so
> Reviewed-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
>> --
>> 2.49.0
>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


