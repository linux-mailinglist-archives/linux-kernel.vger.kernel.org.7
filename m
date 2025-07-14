Return-Path: <linux-kernel+bounces-729247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF884B033C7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 02:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25B081674B5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 00:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC6717B505;
	Mon, 14 Jul 2025 00:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ojf4+CFQ"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA69E1CD0C;
	Mon, 14 Jul 2025 00:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752454118; cv=none; b=AUvJEK4Wx7wJQmv3oKmNyIrS0BnKXM2XOLa3N2axq1k0oI3YMyenwnt0bvXhf0JJ9FNwlgnKw/9IDy0czgu7v7WkE5r1lJgy5yFEju0+kVXeIB7iboHoIrDsc6f+qlSgEai+jM4855cg9wcW5Sh1PAYm8wLgfsK5+KfeuEoC00k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752454118; c=relaxed/simple;
	bh=qBVLc6fBUdI7Bsac/u+u0fq5ykRn1Yj7Fj0fyW93xMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CmPkYJr7osPl53pEVhA0BlERXKVLCYMngs820q/uWUxQqG5uBFVJ8EXHXGPrblIUZNqTtfGzbU/oPgE6oPxSDg1QMUcP7LqMo+zvUNiDTzv8dxUqLYhDpeV5RvolX3RBnovig+DGfthsEIhrorMT4wPKRDdawWKtVHztu+EpeJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ojf4+CFQ; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b2c4331c50eso3466658a12.3;
        Sun, 13 Jul 2025 17:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752454116; x=1753058916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlGfg6+RS0/8umWyykq+45w1614vFv0m/mmrlsZHej8=;
        b=Ojf4+CFQVN4FlrNaT8zzUZGlcqdYJMsGPVxPmc2fAsVxYqZIPIyF+dWmWaRRZqMQff
         qCxd8bJ3nrZvVjLWC57nkAC3EZhA0Ank1Iw8v0fIa4hEn8YU//5bLSpQScusk5xaHIWi
         Lcg+cysRlhZwo+P0t3mz51ZvisRnO+yNNRiAiCHFfKFzvvFb8D+OvW6R6Ykfk22yhXT4
         fGit6EzzxYLJJWKq6oYssnwlv6MWdpibYSGOTaz+xZDX7MN8Q34mOYmOhMXA5v1jlJCt
         JtKnRsQW4IxV+4O3NxiJ16p2Ja0jLuvjmisWkd1+JI9+0EZJEN2PknJCOMtHijtjI082
         kciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752454116; x=1753058916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlGfg6+RS0/8umWyykq+45w1614vFv0m/mmrlsZHej8=;
        b=rreR/DUqOQDpbG7GVoEYWTP88v5493wwSeE7fBGTPXnxxFtQihTncxIfxbZ3aDqOXH
         ND4Us67YSGxZd7XhWlIczKRqYxzJe/8Kd5SJ/gNVbP07sBy0rKfvo+DKIm9wsEAvTq5Y
         vhyrLcf9BVM/zJ0OpqqTMaUGTAT+mtk4tse1x0LFv7MCVH2giKjY3WEUQ5juQB2UkoYw
         wm+cMMjVAGTxGuuHFpHoPvWLMQis2jr2K7/e7Z+LhPF2JHRCt4xpmHKRGKY7vAXgLgQu
         zPU2DUu78Qrq6JBw3bL/yNqxnstWpQmbPrIS/NHGrX7SBxWHUTKnEph584hzZwU3p0qg
         yDXg==
X-Forwarded-Encrypted: i=1; AJvYcCVXiXkrgcyMf/+WZ0ssotADW8td/U/0YARXsoubLqWW8DNe7t8w8kgqp2uGFoBS9+6I6Vo0r1MJFou+PUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4eiF0ghNfFAYcJ9UKQvNE1ksnecrKV11n/wGyn4zy/sRdeWlW
	NORqVoZmzzV3UdzUP0v9G93hnHzfU8+pCYkLGsdyPw0UiHkJebyhbg63bJY2QNGT
X-Gm-Gg: ASbGncv6gzk/FA8Q1MJ1NV0x3KSj7DudGQEsk3ai8gQ0j95fnNz642abHT1VE/5bfrJ
	ECrM/KGvaKgLckSsfiby513V87kLQ463RQtH465Dd70n+5ruCThRpVkPZ+s4zeQ75o9sYo6uUMw
	YLQI9sWPVSRzW0VfdqsdAfMsPjB3YN1eAv+zKGMAeEkbOEsZFox6HplBKYAfEOQbKQyYDsYkSRF
	g0wTLN47dPPc5aRoor5PIvkWhnYhjGRfCFTtNT8LCTi58ZjxOwIAHBZeQcxVytISV7etaTnEkJQ
	iM+f7m6t1X8dja7OhBcnnqPFLM4zX3d9/HhDejBPrXKgFjWmTCeKUcuJROdr1kOYH32uEBTQNLJ
	a9UsSnIKf5QKH6SoGzZJg9g==
X-Google-Smtp-Source: AGHT+IFKzCCHqzYjKRAR+ceG5nX9KmnkL4pm9nq+EucL+t8je9ydIAD9t1s8XHS9iTVp8oXMk1PN5A==
X-Received: by 2002:a05:6a20:c906:b0:218:5954:1293 with SMTP id adf61e73a8af0-23120901f07mr22755505637.34.1752454115669;
        Sun, 13 Jul 2025 17:48:35 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b3bbe5baf70sm8884319a12.32.2025.07.13.17.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 17:48:35 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: devicetree@vger.kernel.org,
	Han Gao <rabenda.cn@gmail.com>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Chen Wang <unicorn_wang@outlook.com>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Guo Ren <guoren@kernel.org>,
	Chao Wei <chao.wei@sophgo.com>,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Add Sophgo EVB V1/V2 Board support
Date: Mon, 14 Jul 2025 08:47:50 +0800
Message-ID: <175245405814.143339.1204072050512603486.b4-ty@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1751700954.git.rabenda.cn@gmail.com>
References: <cover.1751700954.git.rabenda.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 05 Jul 2025 15:39:53 +0800, Han Gao wrote:
> Sophgo EVB V1/V2 [1][2] is a prototype board based on SOPHON SG2042 [3].
> There are many of these two boards in the hands of developers.
> 
> Currently supports serial port, sdcard/emmc, pwm, fan speed control.
> 
> Added ethernet support based on [4].
> 
> [...]

Applied to for-next, thanks!

[1/3] dt-bindings: riscv: add Sophgo SG2042_EVB_V1.X/V2.0 bindings
      https://github.com/sophgo/linux/commit/a42a510c1a9119a8413e20fe09ce3c3cd85ea7db
[2/3] riscv: dts: sophgo: add Sophgo SG2042_EVB_V1.X board device tree
      https://github.com/sophgo/linux/commit/1bf2708394942e047e08146dc8d2a34c091280de
[3/3] riscv: dts: sophgo: add Sophgo SG2042_EVB_V2.0 board device tree
      https://github.com/sophgo/linux/commit/6ca1c3d005cdb9bd619a2dec6ed63ef9ba29eb37

Thanks,
Inochi


