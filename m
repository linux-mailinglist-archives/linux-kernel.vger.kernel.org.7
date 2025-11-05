Return-Path: <linux-kernel+bounces-887160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 030ADC376CE
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 20:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A000E3BB2E4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 19:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3024E318151;
	Wed,  5 Nov 2025 19:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOrMX1ZG"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A11A2957B6
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 19:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762369517; cv=none; b=Refi8d2u+HKfwI+60/jcXLgeXQ1AvZG4u06s0Q9O4nGK+LznaDfVOel4YM5AaDOPMiKCBgBHoBGGQj3T177wqu/jSh61M/vCzxa6z31WxKk6+eFmJmjMgbDTgJZdFKKrW7+f/RJQGSDD9/C8lyrfaMYV5B9nElq0yvJj+7jrG+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762369517; c=relaxed/simple;
	bh=u9rmZpBvMezDctwJo0rwiGqkxhnz+tnImP6t7UnhM5g=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=NJFmW0t6AWSIiwYUnw6SdQXNBVbyz4gKSB2M43tmb45vlJHShdKntKs08ydrdd1cwnDDQdz798ovygHz5m7oWEuK/zZHah3Y14Up3xIynek5wS9MtYIHQgzFYB5Ki+ABvifuZKyueP//rbr3j41dJsK+fco9fPFEdYmns4nUylE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOrMX1ZG; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7a435a3fc57so216523b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 11:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762369515; x=1762974315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0oPPPAsw+FYjV2RdYT3vlBD7M9XMtEjJDNDkXAtf5Q=;
        b=YOrMX1ZG3qRuJxf2YxT2qxF+pcSwNmUVq6tKJytWmBHayJHeDJiFfcHcZxGNuhxg5N
         bwRFLFhfl+v94oQaJFAlAT0DVScNG1otC15jGL3HwXsMl8A6pJgKipsLKg9I3tZ6Z7mj
         aBLxHBsXcq6Z5TJthgf8dPKe2kKSmDHI4pLGE0cHfp6tfD8eg3xhcfG6hM2X+eCd73yZ
         vuurpj5Zkd2XOAAL28N9lmJYGYE9KdgAineEhe2l+sOYGJE2n7qXwZNojtc9hqV2JSPY
         VxwMMMlDhr+V14zL0Eg7zVu4Y4Vt5WvJ3XzrT4d6UA5/4REyaG4r3+VZEbmM92I9uzLZ
         aoIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762369515; x=1762974315;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o0oPPPAsw+FYjV2RdYT3vlBD7M9XMtEjJDNDkXAtf5Q=;
        b=a4VolmGGrVszXzQmsdiguAoyIQ+YhOn897xz7PZ9L1eheGpVMGHGj+iuQ/Jalltrxc
         8fpvU261hzTcL6tAQNCRYLVoMoPEaazqmyk3kHCMX4C+QP2aNFsIbUYzrXrxP0kRB+sw
         VXJV/Jikc1X155NcsedHsMrwOvv/Oh/IczC2iFn6ECOT0OxsLGABRQOeNjB7o3PKgVRt
         +HSMhK8QBsyuBOqxScBhYe601BhqFLlZ1OOhvoXaAvjuG+M1wkcgbC79sR/GkDCWIJLF
         EVhrRI7/fxKlkc024mfDEJ7NfKVzHH7fVO3/DGATsZ3XFqLs3shBzSE1Y0MlE9m+v0G8
         vYQA==
X-Forwarded-Encrypted: i=1; AJvYcCVVoZ8c3XYQu64jIbXo+H+ZzGiuAlF9HjD11WC0CzSdbq1rb5UsW7DT8kvkGQvVxVmRFdLiLf2tE+lrDOg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1s8maI5ACq9ZQv7/VgPw/pswuJ9DB5X9hhaOqfD9nIj0qseED
	HRGBw7KH5n3S91g+PlzT/CGK0V/YCoIeu/6tdO8iEd1N1X+fHz23/al+
X-Gm-Gg: ASbGncuR+uovKsQhKXuT2AGg/guyspPsvTRobOMOjoqUzSr73JgZq0PhfWu6B9pmPx8
	JjcxJKoL1Sq1v9Ee9uXl0F25Zl0fytIbDuWvMa5RrrRiWkyZongejTYy6S5ro1OnGQJYL91hePN
	b9ejyhpB1x11Fwbux4/t+m3n3718MAUM8zrefXVyrB9b4qpMX5d4qhYFpImsX7r61W6IbRaNbyX
	eal9qB7M91XQqKOHKK+wxfjN2lUQl+rYWatpZOddB+WgXrk+NNl/WPd1WThFtrz+l7y/XM9pYIs
	844Lme8fOiD1nufmDa+IhHGp98PZSWapj8i65IwgJ1v/OcIdB9PlW6vE30l5D5uMFpE2gd9JK/2
	RVDusiPi0XKO5QmxAWa3Heyi8BKzv45Xelbg3EgLQpmQNh03Yga6KCWKrtj2qqIPcNcsAdCJ3bK
	7wY7vhcw==
X-Google-Smtp-Source: AGHT+IHgECVR1m9iJ0n7GUB8KKihGMta471ZrUTiheONsefGEk8IBr4BJBrzRXYyPpsTSEE5KPjH+w==
X-Received: by 2002:a05:6a00:1705:b0:7ab:3454:6f2b with SMTP id d2e1a72fcca58-7ae1f19a6c5mr5279780b3a.19.1762369515268;
        Wed, 05 Nov 2025 11:05:15 -0800 (PST)
Received: from [192.168.1.13] ([110.226.177.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af7f84fc12sm165733b3a.2.2025.11.05.11.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 11:05:15 -0800 (PST)
Message-ID: <4981d33f-c45a-46d1-b091-e3d5989c8516@gmail.com>
Date: Thu, 6 Nov 2025 00:35:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 ssranevjti@gmail.com, syzkaller-bugs@googlegroups.com
References: <690b6df3.050a0220.2e3c35.000a.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 l2cap_unregister_user
Content-Language: en-US
From: shaurya <ssranevjti@gmail.com>
In-Reply-To: <690b6df3.050a0220.2e3c35.000a.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test: 
https://lore.kernel.org/all/20251105142251.101852-1-ssranevjti@gmail.com/T/


