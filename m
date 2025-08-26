Return-Path: <linux-kernel+bounces-786015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AB9B35384
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 664451897662
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 05:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7C42D3237;
	Tue, 26 Aug 2025 05:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHKrC6wO"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A360B29B0
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 05:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756187217; cv=none; b=GysLtvwzNm3FP/lpA11Hta+uURlA8mjB8buMNfMzpoKt7lRlD0kfoePi/tHOBL7YmWeg5UR989d+Z8tNqusi0OcdGD6AGbASPCJvn2ZbvVzxcUiG0nimJ85Ir/bXnC8t7APyPdSw6aArcJaKBSaHpabQV4Gr2FZFwWEp7+fQ/1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756187217; c=relaxed/simple;
	bh=1EA+R4mla/tEY05XIC96jNQEV7znGqYBY3xI1jbIUzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bFPj5+xFa2thbzo+A84RssrtbyeNO9ibP+/NXMaMKwRbQFlDtm4OTiLlgDQMLgicvhGOTZIOUyJaUbACPavaqBuc+ZJ0R/EeppbJmlF3b3uy9kwE4XC3dyndM/WjF7HmnZx0/9lZlLasWLoy+UyY3Q0TQNzyJR8X6re7pIREd20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHKrC6wO; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b49b56a3f27so2775363a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 22:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756187216; x=1756792016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ShKqPhVZOpp+9duYArjewTNGLMlFasya/285nJWCfrM=;
        b=VHKrC6wO9ymCnRFol3MMvLzQTepXEd03IRnm4XqTAQC0PXk1Ig/S2VefvIQbjLs8Ng
         KU3IkB7qmNMFuF3eZfsgOcEaEe7gY7bwfemxZXIK0lrdVIxS/WU3VqgzlvnKMcUX8c7a
         MEPfkDT5T+AwDqaCquGJnROI9KfpOYbDzpGnoohi1Xdd2fZYPAWzKFzGYUi8tqSrilLl
         7V1af+3MYzBMtcIfwe/LFlrwlFLxtMZUFYqgOSrAFXZrkTriLOI2pKAqBnj9uXiX7HmB
         mJz3ZebyTyMYBrbQ2ixg4/40WyLZEzv7KWQdlNW9DbQX413k5sJUm4ACYSsiSbcfXiOi
         rnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756187216; x=1756792016;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ShKqPhVZOpp+9duYArjewTNGLMlFasya/285nJWCfrM=;
        b=Tz9rr/Go5M9b0eAITQXlJO2FDc6a69IZrb3RIdIJNlZcPKshu/7MXwzYLX1FfppYtj
         OKN9Jpm3mr8i7jQD/7BfoJU0yfXH4oFdoEi/j+tI1OP2d0k6Jfqw8VJtkpPF0RxS+bCA
         D23/vxcxK0EkxaCcdlb56q/LDoFsaLCJsYow/Kc3DfqW4OCmNvdaFe7QlHILvEkvB1EU
         5pFUaerHUdfJRpReDvB033GwuLDUBwugqOjv1/BX1wdhWpp9JvOpqf8MViWASPiWujpr
         0rGoW02NkyvOh8imAubRuzMZ0HiSA3KM6m6H1YptQCfid8NmofavR2ge6A0aP/xmbzda
         /JcQ==
X-Gm-Message-State: AOJu0YzlEL/iqSspbDpsC1K7r0KkECtertsA8Vg5ZIN/Ry8UthX73r9U
	6/CTfuYtbgcgm5IKLtDdxwKXUe2i+Ck0EacJVM3YPgJqOWYLYYuBFG+80ECm92QdmaY=
X-Gm-Gg: ASbGncvz1OYm7Z2dBSE1SURYWAL0uLsOqKlt1qkLwDmFt9ogB31C2KQbeqUbDEFqBic
	JxxkMSg7/4E5CfdGgHjUB+sLkrAmSKcT37nm9LXLPTFcU/ji1KKIzW+2TFjrCQ1CaGw3g6C9Ae/
	+NrdNSDfpDu4X+RVfr10Svx/gUmN7p/ZiHP9+J3QdFl2Fww6Pe4QnA9oSPHAYkxCmAD752TKqP8
	717DK9R3SEIjcNUzHFWuztCPtNKvFexTwr33VJdz0bMIfJktO1cyIVGkjWFH9bdbmfTxzQHJvf6
	H4MNeRZSeHVO5gI0zVmQv7l7kmcohgDb5l094M10lVJNohqGMZuQOTSUPgcRSBnOzyFgdL4NLFo
	+5XG4vaIRS9oSw3/vuTk7
X-Google-Smtp-Source: AGHT+IFhko4t/2TBzfvth/x8eO9+CTUuOxtey6q0jccNMEVS+w4L9zE34Y8Lf4/UUeNglLd7NUVjUQ==
X-Received: by 2002:a17:902:e54f:b0:246:a532:3343 with SMTP id d9443c01a7336-246a5323a3cmr119727595ad.10.1756187215835;
        Mon, 25 Aug 2025 22:46:55 -0700 (PDT)
Received: from [10.2.0.2] ([149.40.62.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-248681adacdsm6076415ad.10.2025.08.25.22.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 22:46:55 -0700 (PDT)
Message-ID: <255e3bb6-be3d-475c-b04e-bd2f5faeba9c@gmail.com>
Date: Tue, 26 Aug 2025 07:46:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 3.17-rc3
To: Paul Zimmerman <pauldzim@gmail.com>, droidbittin@gmail.com
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
References: <CADo9pHjbJw9HXBqboLHaywAAjeEmMjnQfZnCXjTRVF3nHZh8rw@mail.gmail.com>
 <20250826054033.38175-1-pauldzim@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Herman?= <rene.herman@gmail.com>
In-Reply-To: <20250826054033.38175-1-pauldzim@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26-08-2025 07:40, Paul Zimmerman wrote:

>>> As suspected, rc3 ends up being a bit larger than usual, to balance
>>> out the tiny rc2. Yes, 3.17 seems to be generally in pretty good
>>> shape (...)
>>
>> One would hope so, it being one mere day under 11 years since -rc2...
>>
>> https://lore.kernel.org/lkml/CA+55aFz+3JzdB+sZgOFfzd9zczL=borNgLwZykx=_tOMD6n4qw@mail.gmail.com/
> 
> I think maybe Linus has finally blown a fuse ;^)

I don't know what it is, but I've here been pretty consistently typing 
e.g. "2.6.16" and alike.

Maybe just go Linux 25.09 for the September 2025 release... :)

