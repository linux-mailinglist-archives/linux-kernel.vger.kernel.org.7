Return-Path: <linux-kernel+bounces-751989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E601EB17007
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DD6B3A9CD8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E911B2BF011;
	Thu, 31 Jul 2025 10:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="gimaS8qL"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671B72BEFFA
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753959591; cv=none; b=QpYNQtfhEQXgjz5xInzIloULCCHqNDFw2VyPNnBsrSwTW74enNbPIP8EG2kTsZN+bEHUP7O1ZtHhz9D9HI8emqfJI4qhor/UVECL8uKY5YYZIhuMd7xT/L89N7QpwQnH7gP8IV+YQ2aDW8Mxvixgk6p9Gm5BeV3mQ5ka++PekrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753959591; c=relaxed/simple;
	bh=qcFLLz1GbdDaYA42Y0QQjz1LNJHsASEanA5yq+vzrWc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DRi52rYCBb/bs09dB9I83C0PD/5Ddv3bdfE9Dwo2GbQ+7/7fy4HaOgTucrh6Mhqq+LSnCUA5S9fKvmf5o9XuZaqdkfBKVJXSZczpxPmOEELVtCDXAzCFNGHTp7ebcai5Y0fwOaNbed0t9M2hIgIuuj9HbT68MJT5W7nkesXM2c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=gimaS8qL; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-748d982e97cso250059b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1753959589; x=1754564389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GXJvbgHjesZpC+jSaVR00lc3EREU6v3NKG2m8cKc+mU=;
        b=gimaS8qLTakBEDICmawJngzwm5PGf+3Gs2mv5YdU87eD3UQkicMtHTD4m9sGxBTNLi
         /JUc2nIyY0VPjV0W4czJJgSpfhl5HrG8DEYa6TZ9rSIHaCuOuygHMkxhenG25N59mcfp
         cYMMTiJaLZPQd8zhomo9RU2ECAxkJYZYJirjcOjgroEiVPEjN5DtQEEwi+q9dmtJNqIM
         xAuuuQ55YbVR1s4VoXjClpANmcNpy1SiFMMYEuHpOd01t1Suo4qXQONP9ztVwBei7c11
         x7fh2t26kxYDRHfhxZHHBzOJJ/HaKoyJaGjDcQNS2a3/Eg9QJP8osGOFcaKp4mfCjNiE
         y5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753959589; x=1754564389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GXJvbgHjesZpC+jSaVR00lc3EREU6v3NKG2m8cKc+mU=;
        b=ijZi+pGrosNCgfnADItFT2IoM5jD5CFHol0PswBr6wJV6uFw+teKD1RSFivi7qbeT4
         lO7Zu/Q0LN7KDKUkmWNrxOu5e/jenN8qxBMMiTg2/tiaMVGbiPyQXN52rO01pohXygYb
         AEMi/4Pr2HHuq4jIY+1OiDrUTBuEWS72QWP2uyD7pgSbRlAsedm5kCzA+skQBvUDzUS6
         G9ycL4tyUSbaJfd4VXzVn0e8NV9OgjYZsWkJQ0KMz09pC45zBvJJ5L+dLK8nVKbmcGzD
         3xgtEfW5sUL+iV49BclQwVDfQnZAVXyht6YK3RtQBftVNeEanZu67tMEGCi8On59zig3
         U53Q==
X-Forwarded-Encrypted: i=1; AJvYcCUerNO7Ymvj5rf0vqQmzMh3XLzWPyCcGmwa8vz0Ra1Xqcjg3viviXu82A8aBa7GiNpKmpdTY/wwNvtCmvk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy61wincYhFUw1cKqOKZlDtbPuNrV+vyrq54nAEG96smES0tDl
	1tyC/bU7MiI9xsYRm8qGU3JaVp56dfCHhkvdEwZ6Eh7IxxPweEk2ktkJYa9VmGxEQQw=
X-Gm-Gg: ASbGncv6vLD8/lf15fTxxYK61pGR9Fw2JZ5nLGGKNnECbjpe1g1xhHpAXh10orqax5h
	0uMZxMLYIEZf7Io1S+FOpSVAFPij1CYK4eeL4JdUSidKxB3NYkC7DB1YUKT3Jp3XuMhDa99Alv7
	6hsuioJiFNnTLwBy7AM8wiHhKqKLLKmh+fu4tAwkgi4BmXlU8Hb3cUv9RgsVKSkAmmNFP4UWU1P
	Sv9E6cIiW6zS9oViWWrx/AMRcqU2mOyqvBIiWopVuj233oGcs2z+GLkCW7B6sVhEwGCSC1x86Fg
	Kv00I7X1MX1/rgSLcljoAeccVXcQQ5VfPeuUhI5q/KtjOPNsaxiopoxPrCdFohdJdZUQAAPQ29l
	mdlcRbbfF9Tu0x0OKSknDmJzBjwa6+8IWuzU2q06ChGnN0C6fzKsV/ZrNqODh3xQ=
X-Google-Smtp-Source: AGHT+IHSD6HZ4TtwA0/CmndpR6jjB/vOZJF6QlYkaD5NmrE8cMEO+NeylsRZgkYlMog8DwFz41gg+g==
X-Received: by 2002:a05:6a00:398b:b0:757:ca2b:48a3 with SMTP id d2e1a72fcca58-76ab161afcbmr9144463b3a.9.1753959588315;
        Thu, 31 Jul 2025 03:59:48 -0700 (PDT)
Received: from yc.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfd0279sm1332339b3a.98.2025.07.31.03.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 03:59:47 -0700 (PDT)
From: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To: dianders@chromium.org,
	neil.armstrong@linaro.org,
	jessica.zhang@oss.qualcomm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	treapking@chromium.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [PATCH V2] drm/panel-edp: Add edp panels used by mt8189 Chromebooks
Date: Thu, 31 Jul 2025 18:59:39 +0800
Message-Id: <20250731105939.2692654-1-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a few generic edp panels used by mt8189 chromebooks, most of
them use the same general enable timing 50ms. For BOE-NV116WHM-N4B and
BOE-NV116WHM-T01 CMN-N140JCA-ELP the enable timing required 80ms. For
CMN-N116BCA-EAK, the enable timing required 200ms and disable timing
required 50ms. For CMN-N116BCL-EAK and CMN-N122JCA-ENK the enable timing
required 80ms and disable timing required 50ms. For TMA-TL140VDMS03-01,
the enable timing required 50ms and the disable timing required 100ms.

AUO B122UAN01.0:
edid-decode (hex):
00 ff ff ff ff ff ff 00 06 af a4 04 00 00 00 00
31 20 01 04 a5 1a 10 78 03 54 c5 9d 54 55 8f 25
22 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 fa 3c 80 b8 70 b0 24 40 10 10
3e 00 06 a4 10 00 00 18 00 00 00 fd 00 28 3c 4b
4b 10 01 0a 20 20 20 20 20 20 00 00 00 fe 00 41
55 4f 0a 20 20 20 20 20 20 20 20 20 00 00 00 fe
00 42 31 32 32 55 41 4e 30 31 2e 30 20 0a 01 7c

AUO B116XAK02.0:
edid-decode (hex):

00 ff ff ff ff ff ff 00 06 af b0 52 00 00 00 00
2e 21 01 04 95 1a 0e 78 03 5b 35 9f 59 55 8e 26
25 50 54 00 00 00 01 01 01 01
01 01 01 01 01 01
01 01 01 01 01 01 5d 1c 56 a0 50 00 19 30 30 20
46 00 00 90 10 00 00 18 00 00 00 fd 00 28 3c 30
30 07 01 0a 20 20 20 20 20 20 00 00 00 fe 00 41
55 4f 0a 20 20 20 20 20 20 20 20 20 00 00 00 fe
00 42 31 31 36 58 41 4b 30 32 2e 30 20 0a 00 bd

AUO B140UAN08.5:
edid-decode (hex):

00 ff ff ff ff ff ff 00 06 af ba 8b 00 00 00 00
10 23 01 04 a5 1e 13 78 03 7c f2 90 57 59 93 29
1d 51 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 26 3d 80 b8 70 b0 28 40 10 10
3e 00 2d bc 10 00 00 18 00 00 00 fd 00 28 3c 4b
4b 10 01 0a 20 20 20 20 20 20 00 00 00 fe 00 41
55 4f 0a 20 20 20 20 20 20 20 20 20 00 00 00 fc
00 42 31 34 30 55 41 4e 30 38 2e 35 20 0a 01 29

70 20 79 02 00 22 00 14 7b 63 02 85 7f 07 b7 00
0f 80 0f 00 af 04 27 00 02 00 0d 00 25 01 09 7b
63 02 7b 63 02 28 3c 80 2b 00 0c 27 00 28 3b 00
00 27 00 28 3b 00 00 81 00 15 74 1a 00 00 03 01
28 3c 00 00 60 51 60 51 3c 00 00 00 00 8d 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 31 90

AUO B140UAX01.2:
edid-decode (hex):

00 ff ff ff ff ff ff 00 06 af ba cd 00 00 00 00
32 23 01 04 a5 1e 13 78 02 ca 31 9b 5c 58 8d 26
21 4f 52 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 60 3f 80 a0 70 b0 64 40 30 20
96 00 2d bc 10 00 00 18 00 00 00 fd 00 28 3c 4e
4e 10 01 0a 20 20 20 20 20 20 00 00 00 fe 00 41
55 4f 0a 20 20 20 20 20 20 20 20 20 00 00 00 fc
00 42 31 34 30 55 41 58 30 31 2e 32 20 0a 00 46

BOE NV116WHM-N4B:
edid-decode (hex):
00 ff ff ff ff ff ff 00 09 e5 45 0d 00 00 00 00
1f 22 01 04 95 1a 0e 78 03 0b 55 9a 5f 58 95 28
1e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 09 1e 56 dc 50 00 28 30 30 20
36 00 00 90 10 00 00 1a 00 00 00 fd 00 28 3c 30
30 08 01 0a 20 20 20 20 20 20 00 00 00 fe 00 42
4f 45 20 43 51 0a 20 20 20 20 20 20 00 00 00 fc
00 4e 56 31 31 36 57 48 4d 2d 4e 34 42 0a 01 c1

70 20 79 02 00 81 00 15 74 1a 00 00 03 01 28 3c
00 00 4b 51 4b 51 3c 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 65 90

BOE NV116WHM-T01:
edid-decode (hex):

00 ff ff ff ff ff ff 00 09 e5 df 0d 00 00 00 00
01 1c 01 04 95 1a 0e 78 0a 81 15 96 59 5a 9a 29
1f 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 6b 1b 56 64 50 00 1e 30 26 18
44 00 00 90 10 00 00 1a ef 15 56 64 50 00 1e 30
26 18 44 00 00 90 10 00 00 00 00 00 00 fe 00 42
4f 45 20 48 46 0a 20 20 20 20 20 20 00 00 00 fe
00 4e 56 31 31 36 57 48 32 2d 4d 30 30 0a 00 83

CMN N116BCL-EAK:
edid-decode (hex):

00 ff ff ff ff ff ff 00 0d ae 5f 11 00 00 00 00
08 22 01 04 95 1a 0e 78 03 46 a5 9c 5b 53 8b 24
1d 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 e6 1e 56 e2 50 00 3c 30 30 20
a6 00 00 90 10 00 00 1a 00 00 00 fd 00 28 3c 32
32 08 01 0a 20 20 20 20 20 20 00 00 00 fe 00 43
4d 4e 0a 20 20 20 20 20 20 20 20 20 00 00 00 fe
00 4e 31 31 36 42 43 4c 2d 45 41 4b 0a 20 01 9b

70 20 79 02 00 25 01 09 fc 34 01 fc 34 01 28 3c
80 81 00 10 72 1a 00 00 03 01 28 3c 00 00 00 00
00 00 3c 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 2f 90

CMN N122JCA-ENK:
edid-decode (hex):

00 ff ff ff ff ff ff 00 0d ae 4c 12 00 00 00 00
11 20 01 04 a5 1a 10 78 03 0a f5 9e 5c 52 8b 24
1e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 42 3c 80 a0 70 b0 24 40 30 20
a6 00 06 a4 10 00 00 18 00 00 00 fd 00 28 3c 4a
4a 10 01 0a 20 20 20 20 20 20 00 00 00 fe 00 43
4d 4e 0a 20 20 20 20 20 20 20 20 20 00 00 00 fe
00 4e 31 32 32 4a 43 41 2d 45 4e 4b 0a 20 00 fd

CMN N140JCA-ELP:
edid-decode (hex):
00 ff ff ff ff ff ff 00 0d ae a8 14 00 00 00 00
1d 23 01 04 a5 1e 13 78 03 28 65 97 59 54 8e 27
1e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 42 3c 80 a0 70 b0 24 40 30 20
a6 00 2d bc 10 00 00 18 00 00 00 fd 00 28 3c 4a
4a 10 01 0a 20 20 20 20 20 20 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc
00 4e 31 34 30 4a 43 41 2d 45 4c 50 0a 20 01 c2

70 20 79 02 00 25 01 09 94 5a 02 94 5a 02 28 3c
80 81 00 15 74 1a 00 00 03 01 28 3c 00 00 00 00
00 00 3c 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 aa 90

CMN N116BCA-EAK:
edid-decode (hex):
00 ff ff ff ff ff ff 00 0d ae 02 74 00 00 00 00
2a 22 01 04 95 1a 0e 78 03 67 75 98 59 53 90 27
1c 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 da 1d 56 e2 50 00 20 30 30 20
a6 00 04 8c 10 00 00 1a 00 00 00 fd 00 28 3c 30
30 08 01 0a 20 20 20 20 20 20 00 00 00 fe 00 43
4d 4e 0a 20 20 20 20 20 20 20 20 20 00 00 00 fe
00 4e 31 31 36 42 43 41 2d 45 41 4b 0a 20 00 ba

CSW MNE007QS5-2:
edid-decode (hex):
00 ff ff ff ff ff ff 00 0e 77 62 14 00 00 00 00
10 23 01 04 a5 1e 13 78 03 1c 2e 93 5f 58 95 28
1f 4f 58 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 ea 3d 80 c8 70 b0 2e 40 30 20
36 00 2e bc 10 00 00 1a 00 00 00 fd 00 28 3c 4b
4b 10 01 0a 20 20 20 20 20 20 00 00 00 fe 00 43
53 4f 54 20 54 39 0a 20 20 20 20 20 00 00 00 fc
00 4d 4e 45 30 30 37 51 53 35 2d 32 0a 20 01 8e

70 20 79 02 00 81 00 15 74 1a 00 00 03 01 28 3c
00 00 00 00 00 00 3c 00 00 00 00 80 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 1d 90

CSW MNE007QB2-2:
edid-decode (hex):
00 ff ff ff ff ff ff 00 0e 77 68 14 00 00 00 00
00 23 01 04 a5 1e 13 78 03 90 e0 90 5e 59 86 25
14 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 35 3c 80 a0 70 b0 23 40 30 20
36 00 2d bc 10 00 00 18 00 00 00 fd 00 28 3c 4a
4a 10 01 0a 20 20 20 20 20 20 00 00 00 fc 00 4d
4e 46 33 30 37 51 42 32 2d 32 0a 20 00 00 00 fe
00 43 53 4f 54 20 54 33 0a 20 20 20 20 20 00 9a

TMA TM140VDXP01-04:
edid-decode (hex):

00 ff ff ff ff ff ff 00 51 a1 11 08 00 00 00 00
1a 22 01 04 a5 1e 13 78 03 83 3d 98 5b 57 8d 28
1f 4e 53 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 6d 3d 80 a0 70 b0 3c 40 30 20
36 00 2d bc 10 00 00 1a 00 00 00 10 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 fd 00 28
3c 4c 4c 10 01 0a 20 20 20 20 20 20 00 00 00 fc
00 54 4d 31 34 30 56 44 58 50 30 31 0a 20 01 f7

70 20 79 02 00 25 00 09 41 66 02 41 66 02 28 3c
80 81 00 14 73 1a 00 00 03 01 28 3c 00 00 00 00
00 00 3c 00 00 00 00 8d 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 ae 90

TMA TL140VDMS03-01:
edid-decode (hex):

00 ff ff ff ff ff ff 00 51 a1 94 20 00 00 00 00
0b 23 01 04 a5 1e 13 78 03 47 5a 9e 53 5e 8b 28
23 54 53 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 03 3e 80 a0 70 b0 48 40 30 20
66 0c 2e bd 10 00 00 1e 00 00 00 fd 00 28 3c 4d
4d 10 01 0a 20 20 20 20 20 20 00 00 00 10 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc
00 54 4c 31 34 30 56 44 4d 53 30 33 0a 20 01 9c

70 20 79 02 00 20 00 0c 00 00 00 94 20 00 00 00
00 0b 19 00 21 00 1d c8 0b 5d 07 80 07 b0 04 00
48 c9 55 48 a5 90 7b 42 21 02 45 54 00 00 00 00
00 00 12 78 26 00 09 02 00 00 00 00 00 01 00 00
2b 00 06 04 00 28 3b 00 00 81 00 14 73 1a 00 00
03 01 28 3c 00 00 00 00 00 00 3c 00 00 00 00 8d
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 ae 90

Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
---
Chage since V1:

- Add edid in commit message.
- Modiy enable and disable timing for SPEC.

V1: https://lore.kernel.org/all/CAHwB_NJ3yQxf9fTMT_cQv50z8X_NKyQMOJEuqDqY-BfKX8QzXQ@mail.gmail.com
---
 drivers/gpu/drm/panel/panel-edp.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index d0aa602ecc9d..91f530e91b40 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1796,6 +1796,13 @@ static const struct panel_delay delay_200_500_e200_d10 = {
 	.disable = 10,
 };
 
+static const struct panel_delay delay_200_500_e200_d50 = {
+	.hpd_absent = 200,
+	.unprepare = 500,
+	.enable = 200,
+	.disable = 50,
+};
+
 static const struct panel_delay delay_200_150_e200 = {
 	.hpd_absent = 200,
 	.unprepare = 150,
@@ -1865,6 +1872,7 @@ static const struct panel_delay delay_200_500_e50_d100 = {
  * Sort first by vendor, then by product ID.
  */
 static const struct edp_panel_entry edp_panels[] = {
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x04a4, &delay_200_500_e50, "B122UAN01.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x105c, &delay_200_500_e50, "B116XTN01.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1062, &delay_200_500_e50, "B120XAN01.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x125c, &delay_200_500_e50, "Unknown"),
@@ -1883,6 +1891,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY2('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B116XAK01.0",
 			 &auo_b116xa3_mode),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x435c, &delay_200_500_e50, "Unknown"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x52b0, &delay_200_500_e50, "B116XAK02.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x582d, &delay_200_500_e50, "B133UAN01.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x615c, &delay_200_500_e50, "B116XAN06.1"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x635c, &delay_200_500_e50, "B116XAN06.3"),
@@ -1890,10 +1899,12 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x723c, &delay_200_500_e50, "B140XTN07.2"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x73aa, &delay_200_500_e50, "B116XTN02.3"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x8594, &delay_200_500_e50, "B133UAN01.0"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x8bba, &delay_200_500_e50, "B140UAN08.5"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0xa199, &delay_200_500_e50, "B116XAN06.1"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0xa7b3, &delay_200_500_e50, "B140UAN04.4"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0xc4b4, &delay_200_500_e50, "B116XAT04.1"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0xc9a8, &delay_200_500_e50, "B140QAN08.H"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0xcdba, &delay_200_500_e50, "B140UAX01.2"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0xd497, &delay_200_500_e50, "B120XAN01.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0xf390, &delay_200_500_e50, "B140XTN07.7"),
 
@@ -1956,7 +1967,9 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0c93, &delay_200_500_e200, "Unknown"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cb6, &delay_200_500_e200, "NT116WHM-N44"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cfa, &delay_200_500_e50, "NV116WHM-A4D"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0d45, &delay_200_500_e80, "NV116WHM-N4B"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0d73, &delay_200_500_e80, "NE140WUM-N6S"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0ddf, &delay_200_500_e80, "NV116WHM-T01"),
 
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1130, &delay_200_500_e50, "N116BGE-EB2"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1132, &delay_200_500_e80_d50, "N116BGE-EA2"),
@@ -1974,18 +1987,22 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x115b, &delay_200_500_e80_d50, "N116BCN-EB1"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x115d, &delay_200_500_e80_d50, "N116BCA-EA2"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x115e, &delay_200_500_e80_d50, "N116BCA-EA1"),
+	EDP_PANEL_ENTRY('C', 'M', 'N', 0x115f, &delay_200_500_e80_d50, "N116BCL-EAK"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1160, &delay_200_500_e80_d50, "N116BCJ-EAK"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1161, &delay_200_500_e80, "N116BCP-EA2"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1163, &delay_200_500_e80_d50, "N116BCJ-EAK"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1247, &delay_200_500_e80_d50, "N120ACA-EA1"),
+	EDP_PANEL_ENTRY('C', 'M', 'N', 0x124c, &delay_200_500_e80_d50, "N122JCA-ENK"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x142b, &delay_200_500_e80_d50, "N140HCA-EAC"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x142e, &delay_200_500_e80_d50, "N140BGA-EA4"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x144f, &delay_200_500_e80_d50, "N140HGA-EA1"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1468, &delay_200_500_e80, "N140HGA-EA1"),
+	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14a8, &delay_200_500_e80, "N140JCA-ELP"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14d4, &delay_200_500_e80_d50, "N140HCA-EAC"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14d6, &delay_200_500_e80_d50, "N140BGA-EA4"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14e5, &delay_200_500_e80_d50, "N140HGA-EA1"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x162b, &delay_200_500_e80_d50, "N160JCE-ELL"),
+	EDP_PANEL_ENTRY('C', 'M', 'N', 0x7402, &delay_200_500_e200_d50, "N116BCA-EAK"),
 
 	EDP_PANEL_ENTRY('C', 'S', 'O', 0x1200, &delay_200_500_e50_d50_p2e200, "MNC207QS1-1"),
 	EDP_PANEL_ENTRY('C', 'S', 'O', 0x1413, &delay_200_500_e50_d50_p2e200, "MNE007JA1-2"),
@@ -1995,6 +2012,8 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1104, &delay_200_500_e50_d100, "MNB601LS1-4"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1448, &delay_200_500_e50, "MNE007QS3-7"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1457, &delay_80_500_e80_p2e200, "MNE007QS3-8"),
+	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1462, &delay_200_500_e50, "MNE007QS5-2"),
+	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1468, &delay_200_500_e50, "MNE007QB2-2"),
 
 	EDP_PANEL_ENTRY('E', 'T', 'C', 0x0000, &delay_50_500_e200_d200_po2e335, "LP079QX1-SP0V"),
 
@@ -2041,6 +2060,9 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('S', 'T', 'A', 0x0009, &delay_200_500_e250, "116QHD024002"),
 	EDP_PANEL_ENTRY('S', 'T', 'A', 0x0100, &delay_100_500_e200, "2081116HHD028001-51D"),
 
+	EDP_PANEL_ENTRY('T', 'M', 'A', 0x0811, &delay_200_500_e80_d50, "TM140VDXP01-04"),
+	EDP_PANEL_ENTRY('T', 'M', 'A', 0x2094, &delay_200_500_e50_d100, "TL140VDMS03-01"),
+
 	{ /* sentinal */ }
 };
 
-- 
2.25.1


