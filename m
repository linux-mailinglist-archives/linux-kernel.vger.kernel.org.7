Return-Path: <linux-kernel+bounces-855953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 59795BE2A9F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 98AAB4F7F6E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC44432D7C8;
	Thu, 16 Oct 2025 10:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IvIkSAKq"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9140332D439
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608845; cv=none; b=mNOa7GP+U7YqSAJ8B8d8ua0YpXdiMDgX5oy1YHv/X+JRnQ/WPiQN8mVNwE5xLId7R2937jHwIqoS19qtuQkCLrx8F/O5rTnRyHM/usaJx3QL/sj3kHFf+PA8oPNGSwQP2qHyI6l8/D91iC+vAIvmTsC81iSbvvwYBegRDCP5U2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608845; c=relaxed/simple;
	bh=GuHdpaWnWYFigwpENImVEQ8FLU6LX49o1UO74ZnhrBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAP/JUZ2doDFkzutjfh4ZuUPGCuYhYhlA7dDh4h8LB1Hhxt3wPBTH7o5aLS4kqXG4zmV4iiWbVhXHT62zyfZauR8jtjLM/huPsUAjs7CjVbZCNyGNdQ2472l0x7CC0cj1HUw/525bABjuR+G2L73ovINzPtNnRhN8ybVFTz2P6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IvIkSAKq; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29091d29fc8so6411015ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 03:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760608843; x=1761213643; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uzhZSXVDw5HBXWXhpgNz8QGmIpqR91GrblzBsUR2jdE=;
        b=IvIkSAKqs0wrbYgEtNn+G2fPOcEq+fFL8J57V83XpTZ71hxTH0Xy0ur0iZNhpcTIuj
         zeZJUDyLzmaAaEw2jF8pf7RIQ0GtDJSp4l/JPtefL6Gfz+uS7QZBfJazqXCrmA4Iho+D
         9Xm6sNIF4efqGmwI9Ww4ok8op3ivPC2qLzWH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760608843; x=1761213643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzhZSXVDw5HBXWXhpgNz8QGmIpqR91GrblzBsUR2jdE=;
        b=EDtu3OdfIoyAaVtwoiksWUMZQ0TJzvHE+F5i6/71WTDlkdUNW+d4R59zZrjzHIZSWI
         gDv8HPQalyX34o/GFslUoVLPcdJ5ErU+NKW3fLgSlxjpHB95xDF+ZS4g1yjg32Jwdid6
         M/DJVUQ5blQTk7D/D54ed6C7565J9R+OpoTcTw5hLL/P+WH6ai4hWkttyEyk9oi876h+
         etGau40uTVkuPIWV3FLCAyLjMJIXGc7uhccqJZ70vs1l165IS9b7WARQtmJ6QjjAHRmB
         WaxzQa6W8Gb+Qb2ihr7CgWkxb9GaW5VO/Y7y0W+Zl4U1sZUBEfzDb7OgnU0mD2r7PS4z
         g+NA==
X-Forwarded-Encrypted: i=1; AJvYcCW42uim7jtp9RA+Jfi9JA2zMeKbn7EJmtOtaCFsUx4uawBS228hhOTrSuHcUK4HwfHUwQTfTHa44VVcmFo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6APlAk4GaY35lmjznpWBOLHQbgdV5dqvd2RGUaRs5MfOaf3Ew
	3kTxGQM2L7ZH9H98h+V52w24dJk0k1jkttfVR9czYJF6WFjuYvMSezyLVq17DkKhtQ==
X-Gm-Gg: ASbGncvyQAtpd15cm/1unPnny56UL9s/Ss5z3IHdkl2QGxY1qE9BzaCTeYOtfAPR7nm
	qFFyYyABJdOly7GZ8OG4/oUk6rFce987RFY/h4obfbNPxLUqAPbSJCGXhBHQ/l6tiZ5fSkF3EIx
	TI8f0r4jaNIgHH+CtDfos4t5Wtr0Ji2fuuEvlFt6CChPX4n2+a1sv8o8lWg6NQz8D3y8zhdqR1M
	Yn1f7OE8/5Whlmbo5U78qyTuVdIx/yOIZRP/1AFb0kJKElvHHprwoRddB/wNzfS7s04Qi98Vazn
	eFOix2mfG41RX8/7A86B+CKtvvzxVWgZs+mxwQxGRYGwbqn0vPz0Z4+UaahEIYwl/P4XqNfPzo2
	6Ms5lEUkZ5GYxwesTChTOsAGNH921mm+kK5/F87cChmMcORuK9ESVaerHrsOWp8eX0wdEkw66s2
	s5p4yibISOTcqDyw==
X-Google-Smtp-Source: AGHT+IFuKHF70rg9myfkHvvqf8ak7ClXze86hhc+4ZWu7glDGpK14qjiuk/CiRAUD3qVgrKVbYIklQ==
X-Received: by 2002:a17:903:2388:b0:290:94ed:1841 with SMTP id d9443c01a7336-29094ed1a6dmr39122505ad.41.1760608842794;
        Thu, 16 Oct 2025 03:00:42 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:98b0:109e:180c:f908])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909934a8e6sm24587115ad.30.2025.10.16.03.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 03:00:42 -0700 (PDT)
Date: Thu, 16 Oct 2025 19:00:36 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Doug Smythies <dsmythies@telus.net>, Christian Loehle <christian.loehle@arm.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Sasha Levin <sashal@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
Message-ID: <ytv4w7uw23fwdkihbgrpegmco6yzkxmzjbakmxtricreou6p6k@rhwxcjq3jvnv>
References: <8da42386-282e-4f97-af93-4715ae206361@arm.com>
 <nd64xabhbb53bbqoxsjkfvkmlpn5tkdlu3nb5ofwdhyauko35b@qv6in7biupgi>
 <49cf14a1-b96f-4413-a17e-599bc1c104cd@arm.com>
 <CAJZ5v0hGu-JdwR57cwKfB+a98Pv7e3y36X6xCo=PyGdD2hwkhQ@mail.gmail.com>
 <7ctfmyzpcogc5qug6u3jm2o32vy2ldo3ml5gsoxdm3gyr6l3fc@jo7inkr3otua>
 <001601dc3d85$933dd540$b9b97fc0$@telus.net>
 <sw4p2hk4ofyyz3ncnwi3qs36yc2leailqmal5kksozodkak2ju@wfpqlwep7aid>
 <001601dc3ddd$a19f9850$e4dec8f0$@telus.net>
 <ewahdjfgiog4onnrd2i4vg4ucbrchesrkksrqqpr7apyy6b76p@uznmxhbcwctw>
 <CAJZ5v0inu-Ty-hh0owS0z0Q+d1Ck7KUR_kHQvUCVOc1SZFqyjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0inu-Ty-hh0owS0z0Q+d1Ck7KUR_kHQvUCVOc1SZFqyjw@mail.gmail.com>

On (25/10/16 11:48), Rafael J. Wysocki wrote:
> All right, let's see what RAPL on that system has to say.
> 
> Please send the output of "grep .
> /sys/class/powercap/intel-rapl/intel-rapl:0/constraint_*"

/sys/class/powercap/intel-rapl/intel-rapl:0/constraint_0_max_power_uw:6000000
/sys/class/powercap/intel-rapl/intel-rapl:0/constraint_0_name:long_term
/sys/class/powercap/intel-rapl/intel-rapl:0/constraint_0_power_limit_uw:6000000
/sys/class/powercap/intel-rapl/intel-rapl:0/constraint_0_time_window_us:27983872
/sys/class/powercap/intel-rapl/intel-rapl:0/constraint_1_max_power_uw:0
/sys/class/powercap/intel-rapl/intel-rapl:0/constraint_1_name:short_term
/sys/class/powercap/intel-rapl/intel-rapl:0/constraint_1_power_limit_uw:12000000
/sys/class/powercap/intel-rapl/intel-rapl:0/constraint_1_time_window_us:976

