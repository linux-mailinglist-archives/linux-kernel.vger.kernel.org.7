Return-Path: <linux-kernel+bounces-894690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE8DC4B9C1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 117653B7F55
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 06:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE45829ACF7;
	Tue, 11 Nov 2025 06:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="QJFoF6q0"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A46E299950
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 06:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762841209; cv=none; b=IO4KPirKWNxGD2wlyhhBVNiF+0EY523KcT5R65Z1402qrAsXaPQwjFsCD/h9uHK9lBCkmtSS0QtDdngkQiRCqsZAdDPQGikWgJEhxazi1SNXjJP1XZ/019oKmYpKu7ClG1Qatq3kqdxML+4o+gYrMvppTZUcU3+rL8rad6g5kYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762841209; c=relaxed/simple;
	bh=vdsHJs45ooO/M+OZIcoQXZlPX9LYJcRdvesRK5hCxHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rk0UmXlhGO8cvCqoDZpRJaWCYL00DLUjlNrT11s3BMKnxJkfiTcxJIgv9JzuAwLbdsR++93cWjloXFeEul1P0ww2qxPrltVgfnKlDuDeo1uBHy7lH8uy4Hzce9TMAkB6kL9RH+tZgiGUVjTd2+0ScmXVNLD6tt4XGLR5aLrCA+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=QJFoF6q0; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=vd
	sHJs45ooO/M+OZIcoQXZlPX9LYJcRdvesRK5hCxHg=; b=QJFoF6q0GnOALu+Gx2
	GNMuuVwsFslbpEM2aXqiIQFmQ8Cq9ouglLmNbJ2LxBJ9LWy/rG/GZaHj7PL5HnOL
	dn81ALbAUnVItW8q3PbqpmzK/3f2NAALAKbq2W9P7DuaHOBdqACnwcOW+6REXZZ6
	WrYXFvuZ86tZpU1r9Ey0tjNzg=
Received: from hpz640.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wCHmd5W0hJprKUPAw--.11216S2;
	Tue, 11 Nov 2025 14:06:15 +0800 (CST)
From: Xiaole He <hexiaole1994@126.com>
To: linux-f2fs-devel@lists.sourceforge.net
Cc: jaegeuk@kernel.org,
	chao@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] f2fs: fix has_curseg_enough_space to check all data segments for dentry blocks
Date: Tue, 11 Nov 2025 14:00:49 +0800
Message-ID: <20251111060557.337514-1-hexiaole1994@126.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3a787685-1765-4068-a8da-d595dd257b71@gmail.com>
References: <3a787685-1765-4068-a8da-d595dd257b71@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHmd5W0hJprKUPAw--.11216S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUzKsjDUUUU
X-CM-SenderInfo: 5kh0xt5rohimizu6ij2wof0z/1tbiex8DBmkS0FA33QAAsw

Hi Yongpeng,

Thanks for your feedback! I've updated the patch per your suggestions:
- Merged the dentry block check into the main loop to avoid duplication
- Check data_blocks + dent_blocks for data segments since both can write to the same segment

Please see the v2 patch.

Best regards,
Xiaole


