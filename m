Return-Path: <linux-kernel+bounces-859202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF95BED018
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 15:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DBB2134CF07
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 13:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01C52D63F2;
	Sat, 18 Oct 2025 13:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxgQBC/a"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7CE28727B
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 13:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760792685; cv=none; b=ZBJobE8JMOzdFKNx+RMIruUe1vaonkVuYwmBCu2PRJ8Rs3B16jMOkjsm0uPr47iLVOFf49ThtEEY6tSgywGOHuBG3IfpECU0ByOpprjizX7/ojdi5fsECS7T1CyPdpCfKjNS/l3MUq2TpNsmvspBgP0XavdHo1w50JTBz95ZHqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760792685; c=relaxed/simple;
	bh=R+KaKUoTMbS3qGkwBTJDmbjeQcTDbiGE1Vr8NkGkL/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AdFPP17APrgopc7RRHSsMlvha7iWEExYlKT2BrQ3Sd8KdAJfTkPvc+iWqmYzUQjRj6fImnQ46izK09hzG8gCEOro7ShNNzOCgbjn7X3LeVoS02agg0/xdoQg8aB9FCKDOmz7dttPhUVaaxsqOrbeWpEBWaavimmxCkGeEbI5Mj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxgQBC/a; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-7f7835f4478so31553256d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 06:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760792682; x=1761397482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=trCRqXRfBn/yxKdZHJTPwmyQCvgYCCi0gPBNAdqxdVM=;
        b=bxgQBC/a2DjERNkm7/nDtx1+7oZElydCVRwThzApZ9S81f5WJrC/iS7XOzONDxn/XI
         yPKpGl2pbOiyr+v1yJHJW1TeDH/A7CcyJlGOj0zHAh/HuaDzIEThTvxh1Ck8zu3X0KxV
         XaTcik3kXkBhp0YnU0cuntz9IivyhLlULDz4m61kGNKOyMASCjOGGOZMMqapznsbn5VM
         U9d9Pn4VxEqYSIIgJumlslpWibxow1ee+sZ2a2SkjfvVBo6CtViXLKztM2W8C/e9qRa5
         K3uSSCZa8qiCRETmW1hUPqwppISNwUNhCIHUKx8byZjLjqGUuVvC4iCOwPF+REx0TyAw
         ZOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760792682; x=1761397482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=trCRqXRfBn/yxKdZHJTPwmyQCvgYCCi0gPBNAdqxdVM=;
        b=osFcIfEMP/d2Pfbh+hE/IQ3gD8R7Kb6Mf6e6AoclbHB8/ki9zha4pyn1cRKMN3CJAD
         TtKZO3eQXLmNXCApt0/HnCPiyVWZsD+HT2SMVts/nmSErQ2GxBcEDTwbSj6FBzfPiFPK
         lbhKBKOg5cEyHwvzxkGem0yz0S/VwihEgq09q3ueCmg3yzGxafZ4bnirxseGK+7YQvIp
         rCItEzXwjHQcCOYS/Fa4RM7kYyMsHohJHuyeDSsJ1GbAIbjOsTfa1kWyXpY7wk/ilc06
         MGzkt2Vs7jdAYj8RiGMy61lFhkeQ9HBpSCoHABTwbLAo2xNhXgU4VpyrMG9rVgHYYs5a
         Z6IQ==
X-Forwarded-Encrypted: i=1; AJvYcCX68px44BlS6kfOhw036IEdC8kq99q4Pc6x3RzK6o8e8wdrscbDhkdSONOosFUuaJTjG52pi0jOJvRpYfg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+C1azkI3XqYz194jAWpOArMKpe+DoodX+AxpUYWkFMdL5e1X4
	HyLguY4WmTXVkIINDVjSQREZGeu02nI3wUjQVMg7N2v289/RT06tfJgX
X-Gm-Gg: ASbGncssbVG+rkzkzNt6gwyeAnMUvODTtzx3VNjc5853ebHTUMP4NahZY34Vg4bz8dR
	bIKWWkrdk5zVPJln2xSDUkA6JbwS7q/VvPU/EQM9pgYQGEu3rbYf9CpUfoXag887QjH0/O/rkzQ
	4ex6NJcTo8xmMIogVMtItRtBYBxOf7ktMXYHqI+ROT+LEi2gopEYkMZNkxEHKtAdn5de93Ll6iI
	za5qz5alMzvZm4E0DNxIwwBNZfhOzMIy5XDNDsURb/VJuSHRkByeVaP8KfcTp2j7QCi1t8w/Ybj
	pkZ+4mSk2QKwvFjgEQGm+JpyJeO7s3jKqbveOlY8+p/GOq5JyA9A43e+IifSUMieBKEYUd9lCPw
	7yO80ijUu9AnBmlTX0KZRmcADzNq8oFbCx8P25rxIkWHc8/TLl3zhgZtifpE8RwlMFQQhT+qU+5
	xH56O/Y9+mSj7KyFR7YtriFEFUYEoz0rfUAodO
X-Google-Smtp-Source: AGHT+IE7kX32IxJFAb9JSe9/i8fvfeClIEH20D/LplyGFeMenVVt53YG8UVPIv0JZpwN4q0Ac2LjXQ==
X-Received: by 2002:a05:6214:5287:b0:87c:d60:1017 with SMTP id 6a1803df08f44-87c2057f338mr107476366d6.21.1760792682181;
        Sat, 18 Oct 2025 06:04:42 -0700 (PDT)
Received: from ideapad.mynetworksettings.com ([2600:4040:5304:d300:275f:6229:da5:6a60])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d028966fasm15840596d6.33.2025.10.18.06.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 06:04:41 -0700 (PDT)
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: rostedt@goodmis.org,
	tglozar@redhat.com,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ivan Pravdin <ipravdin.official@gmail.com>
Subject: [PATCH v4 0/2] rtla: fix cgroup and trace options parsing
Date: Sat, 18 Oct 2025 09:04:29 -0400
Message-ID: <cover.1760791697.git.ipravdin.official@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes 2 issue in rtla timerlat and osnoise parsing.

1. Make -C/--cgroup option more user-friendly. Currently rtla timerlat
   and osnoise parses does not allow to specify tracer's threads cgroup
   name as `-C [cgroup]` or `--cgroup [cgroup]`. Second patch fixes this
   by allowing users to specify cgroup in the aforementioned manner.

2. When specifying `-t/--trace` before `-a/--auto`, trace filename is
   override to default <osnoise|timerlat>_trace.txt. For example, when
   running rtla as

       `rtla timerlat top -t custom_file.txt -a 100`

   when the threshold is reached, timerlat_trace.txt file is created
   instead of specified custom_file.txt. Third patch addresses this
   issue.

changes v3 -> v4:
   - Removed patch [1] as it has been mainlined
   - Resolved merge conflicts with [2]

changes v2 -> v3:
   - Combined common logic into a utility function to parse optional
     argument value
   - Removed change that removed `clear_terminal` 

changes v1 -> v2:
   - Moved removing clear_terminal from `fix -C/--cgroup interface`
     patch to `fix -a overriding -t argument` patch
   - Added clarification why to remove clear_terminal
   - Added `Fixes:` tag to the `fix -C/--cgroup interface` patch

v3: https://lore.kernel.org/all/cover.1757034919.git.ipravdin.official@gmail.com/
v2: https://lore.kernel.org/all/cover.1755018581.git.ipravdin.official@gmail.com/
v1: https://lore.kernel.org/all/cover.1755014784.git.ipravdin.official@gmail.com/

[1] https://lore.kernel.org/all/164ffc2ec8edacaf1295789dad82a07817b6263d.1757034919.git.ipravdin.official@gmail.com/
[2] https://patchwork.kernel.org/project/linux-trace-kernel/list/?series=999703

Ivan Pravdin (2):
  rtla: fix -C/--cgroup interface
  rtla: fix -a overriding -t argument

 Documentation/tools/rtla/common_options.rst |  2 +-
 tools/tracing/rtla/src/osnoise_hist.c       | 29 +++++++--------------
 tools/tracing/rtla/src/osnoise_top.c        | 28 +++++++-------------
 tools/tracing/rtla/src/timerlat_hist.c      | 29 +++++++--------------
 tools/tracing/rtla/src/timerlat_top.c       | 29 +++++++--------------
 tools/tracing/rtla/src/utils.c              | 26 ++++++++++++++++++
 tools/tracing/rtla/src/utils.h              |  1 +
 7 files changed, 64 insertions(+), 80 deletions(-)

-- 
2.48.1


