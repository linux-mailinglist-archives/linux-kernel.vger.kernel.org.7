Return-Path: <linux-kernel+bounces-889450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A187FC3D96B
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 23:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4DF3534F3C8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 22:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2BD322749;
	Thu,  6 Nov 2025 22:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cJLY+pre"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFEE29A9FA
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 22:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762467943; cv=none; b=bRLVrbu4Z2HUq+zkwsr++V2JU7iNP3wvz/ZvEDt0p6/39nU1iog5NpKIJ2gMR24KAA9bA7zBuJcfN8gDsLIXsoIWKYvwmy+UAFLekBdBMuGuOWqtifPy3XlC2VzcCYjt2XO3JvR8JgBR1fMiCGW0/sOVDEIF3pBjMv2y6CTdP+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762467943; c=relaxed/simple;
	bh=c3Lbyug0B8LC1SBsLJoiXKtGPHiW/sjp9Vcgo1geYE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VkdvzfG/lbwLkmPL4GriR2GOMzv11ryVBc5toXskrsOye1mOjIYh4bDMJ44LxtCF6CjC2wFS92jwF3mBmLR9ukuiywDAA736gG4FemjFlBuwOy8+jl5wgbSKTu1IrEdUxEXWk1gr1uCtU+Es0Q6KeW1o1sAGV37wWiTqA8IXhMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cJLY+pre; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-9486d008fdbso5012139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 14:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762467940; x=1763072740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nojW/UFZn0qbslE6OPGihe1YdAm5O0z1Y/2QE55GUN8=;
        b=cJLY+preBPJZGlZ3bZLeWjLc3o+HaU47ziG3X/uFLhgBj5kWfPQ5mnUz+Lhfv6xlXt
         YSwSPoHW0q+h21J0GQ5vJKj2GMcOZajq8Vh9+p54Z1v7G+urMj6SXnlXdRmAMY9RUpSP
         8r0LG8SO2rtl06djLxZwPqibigGRqk+Jqi7jA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762467940; x=1763072740;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nojW/UFZn0qbslE6OPGihe1YdAm5O0z1Y/2QE55GUN8=;
        b=GbMMIwtTkO+g7JoYGez0tLrL6uViRfkeS6n2j6M5wYqLHd+Bz4qYoK4Zeg3BCwP2tB
         EhtmMp5xiHP49xgYcjFESZwWrySWDgrBVYzf4Vfe3Z398nZw50DYr1ZlNQScGjheuCe/
         Zi2SRvx6/KG6iCZ2ADyJUbPcjoQ9hoRP7E9WbZbLC03LFgfCIBta+ogd5XZ05kyOy0wc
         zEGbI1iJYG4Hkb1mWL7QCFJlqKzYY8lExd8XMg/pI+fkZMTXm3V3fLXX7QNBSQcegkvO
         Lz1EwRCkhV43xtdz60KUv6TPe8dMT8jA26ZRVHnLY9GoQfXwLfTcy/9gTKeMfXiTRdBz
         kYDQ==
X-Gm-Message-State: AOJu0YySoSEPwDNf3b7tbKYUVzy2DU7f72oovQpbFcmAWtPzSEToAhF6
	TcMna8cvaWHcHjHs6TpnrY+903lNjrT/a4PxFuzMKTDwWTbeLa4iZrJUioHTNA8RscI=
X-Gm-Gg: ASbGnctfM5ewO14yyMQ6Cl7gmPXb+KDaI6fjxZbEFR9Pu769zL4w3xWmNUjctSg2rYS
	R003EGZqWVZqXgd2iwtmG/IMv30xv/+zEoPPW6ki9xnmGxDPJjMXKcASOapAuvI/FxQ/EEUH0wb
	mb8h3ULuDWmgtf+sngYdSe/Gzfn9RrKX01pydR03wAQS+kL24w/kUTSvHwNxsC8PF56E51XDChe
	t7ABl52lRItiD9lBrjzFe9DQOgBQJ5QcgPmyhgbrfxHlVdvS6hOcQNwmaCCi3Ou7atdadLROxZJ
	8HzgWmSNtfW3+cyY8oeEAK+qIqU4tiwZDM+qGduynFVlW5xiz4GbB2Wxv0CDMOFy6wyCgFR6aEq
	iOFSkRWc/ksCFU8GpUZtswq3mvovrbIi3cKQ3RmQriicNxcGSngMJ7crEU2XibiRZMRQXg/g3th
	az54UTIWW+pQXk
X-Google-Smtp-Source: AGHT+IH0/3GJ4ianQvzZFggnE+5AVLuBjfhvBYg0/6brP9mgyD+T6dTbpZArnCJ/fgMPmOmGaPjq4Q==
X-Received: by 2002:a05:6602:13ce:b0:945:aa01:bab7 with SMTP id ca18e2360f4ac-9488870ec4emr224804139f.5.1762467940613;
        Thu, 06 Nov 2025 14:25:40 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-948889fae8dsm32195239f.0.2025.11.06.14.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 14:25:39 -0800 (PST)
Message-ID: <0abf9a34-232b-4840-b592-672aa277509f@linuxfoundation.org>
Date: Thu, 6 Nov 2025 15:25:38 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/tracing: Add basic test for trace_marker_raw
 file
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 linux-kselftest@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251014145149.3e3c1033@gandalf.local.home>
 <20251105084748.f34e1efec291d420a50a7b62@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251105084748.f34e1efec291d420a50a7b62@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/25 16:47, Masami Hiramatsu (Google) wrote:
> On Tue, 14 Oct 2025 14:51:49 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> From: Steven Rostedt <rostedt@goodmis.org>
>>
>> Commit 64cf7d058a00 ("tracing: Have trace_marker use per-cpu data to read
>> user space") made an update that fixed both trace_marker and
>> trace_marker_raw. But the small difference made to trace_marker_raw had a
>> blatant bug in it that any basic testing would have uncovered.
>> Unfortunately, the self tests have tests for trace_marker but nothing for
>> trace_marker_raw which allowed the bug to get upstream.
>>
>> Add basic selftests to test trace_marker_raw so that this doesn't happen
>> again.
>>
> 
> Looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 

Thanks. Applied to ksleftest next for 6.19-rc1.

thanks,
-- Shuah

