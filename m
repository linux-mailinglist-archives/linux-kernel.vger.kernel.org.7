Return-Path: <linux-kernel+bounces-898509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59717C556F6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD9113A443B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4962F9C32;
	Thu, 13 Nov 2025 02:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chenxiaosong-com.20230601.gappssmtp.com header.i=@chenxiaosong-com.20230601.gappssmtp.com header.b="WEE/wCUs"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6552F9995
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763000833; cv=none; b=Tv1/p3Z1C2F4b5ED90IxLAMABLCVL39vHZ4EfLmlfUXdIyck2UzXaaXjJY9oS8i4WuUTgsZuNt+my2jXuzLH966j4R9X7XrLUslTZ1ZVg7oaFp+ZfoPKPfv3rUm0YOJDXvi9lJNKerZvuqjDjWOlNSwG+PaZT5/t/1KhVSSbqUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763000833; c=relaxed/simple;
	bh=6xdVQlMATcTTZKwxaLThy8BA1nkPY8YAST+SPi+vITc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X/v4tPQqKjNfbuD0cEFJeJmdweyttgxAz+yT2snXuwFc1z36PGvL5afQ5U4X2JVpEsH2aWDOyo9vyf00m19/n1cpL6bVlArQMO/1DaqeWCNDcVeS/NIUEACsz+hHqsLaJXD/Dru279RrwKbDTtLHwxxOUQhkykyB8jkZLBihNfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com; spf=none smtp.mailfrom=chenxiaosong.com; dkim=pass (2048-bit key) header.d=chenxiaosong-com.20230601.gappssmtp.com header.i=@chenxiaosong-com.20230601.gappssmtp.com header.b=WEE/wCUs; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=chenxiaosong.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-297d4ac44fbso10771635ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 18:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chenxiaosong-com.20230601.gappssmtp.com; s=20230601; t=1763000830; x=1763605630; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jf/F/fNYoShIn8vd4fwO07k1j66rpPF7kQ4OChB2ivM=;
        b=WEE/wCUsBvvZkLLgkbnPFGf3cqwuZZ31vD2PBWiWbO7ychbFrQwXPxwUGgAx17S1e8
         Yf/C4N/j5DBDZHBs0q7Luh+j2zqJihwJpxxr7Wc3CfAPQQ5nTQRrOve3/az0moW601fn
         TcZpp/P53UsxyQfwv8vaAhOoC4i3t0dy/bzVk1chteE/wZYtY2XMuO8QSUgHpE0RMhSe
         FM5Bb5GvyL+bXChNSIMktrUL7Q57bwIPRwRZh2gipXJ7hT9v8ARHHZ+oCD/00wYR8cpP
         YXl7SzGw2EXlcjPUqOuWbp2hTIwxfF5awGH/M2mxAVfb16+l2T6WNy7tmEO++VrA+YVc
         Vk8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763000830; x=1763605630;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jf/F/fNYoShIn8vd4fwO07k1j66rpPF7kQ4OChB2ivM=;
        b=kgt/iWOKJu7+39L/mdxutokvZHOHd/f8qEy9iVXRp8j3srykDbV3wv5bKKTg5zUM2b
         CV0t21bxCa7eGredu8X8a4dMR0cT0wqIwYXzYI3NkeosCLGOzvhlKe7N46knkN3iX2WC
         fiOE0eCV5SOHOYbgRjo/etWwa/R2S78aXWJp2baFx8iZWRGtFxV2fKOnYe335flFjcRq
         3M86Q7rUzfDMSySFz6jb/ddk91rME12PDKydhMMOKn6+zlyd+tYo2GLHmDqBG0/FU25G
         mZRi7WDzQ7XFlZjZgVlkIdQD91GOxDwJLtD3EeJdIInJQwNntWekdT9OUTzlbxGjFg4k
         ijUg==
X-Forwarded-Encrypted: i=1; AJvYcCWHfOLlXlx68NtcRUn8kbXRCtSDOcAB6LE0KOKzBpqCxlDSmnFmsPsio7oiaZsjnmUMg6eVJmmMtbtGF2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhy1hxdrGCtOJaXIV4UG9vje3wQdP0funDyuM78Gmqn+k3MzIX
	CzMk8IoC5ee4NF3AXWwMlIYoy6nCYgfmHMjkUTWoA5cS96BBF7qiINUt3ZR/Ym9yi3Du
X-Gm-Gg: ASbGncvGaY9h5lV6LGsaDJqpnItqFM09l9Vmpv+XXjJwCtNfXahh3rmQtbGgQKy8V8p
	HPcGXJ266ZVdkJs9mvzbRbQXeyKKGN0br/CPUwdcz4xaspk+Pbepcx5f/4ULoOUDyauGfGCqrP/
	QGgJ0XKgcZP8xlTfW+tv0PuBmqdXOI9Ll5Q0tfYN+HY0TRMDZEf80BOYyabramU21qhiJ6ldaJX
	oebnNEXsR7ThB5UCioAzPl4m6gWtPigpxT4M4PrNaD2uzSr7xQjhWlSqr9x1zg+PnTgAJpSF8rf
	2admHeOeNtR22L9zdQbNwBGxLlC9gpKpTt3lfots7uuUEk7F20BM8zmzazZj3jyHQWA9QR0tsQa
	zBxdsHyKUA3vN3j0fjcedNp9QdppDVta/hRgRspa1iszk/8NoW5TOrjXP7P+7Hb1qHxKDbHUi83
	7Cf2qK7WXs1ZxYUp7wDEn5a/AGPRSSFA==
X-Google-Smtp-Source: AGHT+IER4+TDctqnE2sQobAK+QCd98kGQkHJSgna3I4yn2VMzIgKov4QjnbIvtN4bm0KnEchSzFESw==
X-Received: by 2002:a17:902:f707:b0:294:fc77:f041 with SMTP id d9443c01a7336-2985a520871mr18729795ad.25.1763000829793;
        Wed, 12 Nov 2025 18:27:09 -0800 (PST)
Received: from [192.168.3.223] ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2346acsm5852885ad.14.2025.11.12.18.27.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 18:27:08 -0800 (PST)
Message-ID: <e690301a-d0ee-466a-82f5-70634859be1f@chenxiaosong.com>
Date: Thu, 13 Nov 2025 10:26:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/14] smb/server: remove create_durable_reconn_req
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: chenxiaosong.chenxiaosong@linux.dev, sfrench@samba.org,
 smfrench@gmail.com, linkinjeon@samba.org, christophe.jaillet@wanadoo.fr,
 linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251102073059.3681026-1-chenxiaosong.chenxiaosong@linux.dev>
 <20251102073059.3681026-7-chenxiaosong.chenxiaosong@linux.dev>
 <CAKYAXd8o3CKcaArMzEifR+oaX2G_g3XuEjFkBtPhyO99pKQO+g@mail.gmail.com>
 <fd9d8a05-32e8-4f83-8e40-a6497dde1ed5@chenxiaosong.com>
 <CAKYAXd-niyc2df5BvZYBzo-fOX3WcTjhgtxh5aQyHrVwL4ONsQ@mail.gmail.com>
Content-Language: en-US
From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
In-Reply-To: <CAKYAXd-niyc2df5BvZYBzo-fOX3WcTjhgtxh5aQyHrVwL4ONsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Namjae,

Please do not apply patch 0007 yet.

The struct smb_hdr seems to be used only by SMB1, while SMB2 and SMB3 
use smb2_hdr.

Should we move smb_hdr to a new common/smb1pdu.h?

Thanks,
ChenXiaoSong.

On 11/13/25 10:12 AM, Namjae Jeon wrote:
> On Thu, Nov 13, 2025 at 10:46 AM ChenXiaoSong
> <chenxiaosong@chenxiaosong.com> wrote:
>>
>> Okay, I'll make the changes.
>>
>> Once you've applied some of the patches from this version, I'll
>> immediately send the next version.
> I have applied all patches except 0006, 0012 patches to #ksmbd-for-next-next.
> Thanks!
>>
>> Thanks,
>> ChenXiaoSong.
>>
>> On 11/13/25 9:19 AM, Namjae Jeon wrote:
>>> On Sun, Nov 2, 2025 at 4:32 PM <chenxiaosong.chenxiaosong@linux.dev> wrote:
>>>>
>>>> From: ChenXiaoSong <chenxiaosong@kylinos.cn>
>>>>
>>>> The fields in struct create_durable_reconn_req and struct create_durable
>>>> are exactly the same.
>>>>
>>>> The documentation references are:
>>>>
>>>>     - SMB2_CREATE_DURABLE_HANDLE_REQUEST   in MS-SMB2 2.2.13.2.3
>>>>     - SMB2_CREATE_DURABLE_HANDLE_RECONNECT in MS-SMB2 2.2.13.2.4
>>>>     - SMB2_FILEID in MS-SMB2 2.2.14.1
>>>>
>>>> We can give these two structs a uniform name: create_durable.
>>> Please use typedef to define multiple aliases for a single struct.
>>> typedef struct {
>>>     ...
>>> } create_durable, create_durable_reconn_req;
>>>
>>> Thanks.
>>


