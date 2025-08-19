Return-Path: <linux-kernel+bounces-776250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86669B2CA8E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A71AD1C25B55
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E53306D5F;
	Tue, 19 Aug 2025 17:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="jdwRqen8"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49215305079
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 17:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755624512; cv=none; b=RvIoI53/Md/lvLY2DrbUMbWO3O4sM7vD1DIez3Ngswxnq/58bNGQjWZfUS++08IGdv5BbZvJWzour9iFMnhBF91Mf852tGFLBWaZN1YD9HICybvS7VfT67V/s3jt+XXyeojFDYktQvWR8yfNt510FYKteBxln+oBU2qr5Ov8rWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755624512; c=relaxed/simple;
	bh=0xZCle+9kMECxZEBNqTcsT277GbnLsVDr7JNRC4xJJY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=q9qnwwjqvBBkxoIiB5f8JnQZxrPW4M+Qdw17lroEHf8wLajtDvc3FlDw9eKeG29Y8rgmpcbc7CgrGicLnsfvE6rNNNBwRMPhnDZO5Lyghnkk7/WRsvgl9bfIUTxP+AV/RpBpMTfZD42WnU+HEXNCqUh8NtWt9sNUq+cSlIDPwc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=jdwRqen8; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1755624505;
	bh=yyMLXXOY3XJGqSunf4e+P0O4ZejJY59swnsttag6jzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jdwRqen8pEtoByYVdovY2DeZj8nl1dKuhWZtPRlM/HJOmOAyne+zL++Xt05x/FlDf
	 8/4C/BLWfRlummuzFtGMY+R/5gnAmbDjt9HeQud9KcgMeK4o+n0iEOw4LDxXq9Igm0
	 u8tvga3S8EMkZ3qlHLsjJDlx3McLPSbWlzSPpplA=
Received: from zm.. ([2408:8340:a29:3fc0:20c:29ff:fe69:94c7])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 717822F8; Wed, 20 Aug 2025 01:28:23 +0800
X-QQ-mid: xmsmtpt1755624503tiw50na5i
Message-ID: <tencent_541B42A95C2B97DC129A6D86D65387B20005@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnLVixLVwwBjw+qG+SrnrZcWgyJURfIpmqTzP8sqJsgUEiPhlu73M
	 Ef2b4EwPOfpfnzaDHcpkcFlpR0CjgeI8YTm8TMcpM+YU16M7ErEmFKksJxHrxetwNLCr/RBomD07
	 PQjM5/cKvuQY+18NRNesSBM/KhBlhJjFidmHyVntweUKz+cpW6lGZyfPvHhcpnKxU2zpU5dIbUlk
	 HqDk5dOYvbyET3ArB+h91nc9tV3msoPCJe4hMMizjNIbdgV2i+VEL/WdMLJke3JQ+M5oo3HsXycX
	 94yekVgp5LQGB2KRgEDM0VTGny2Ka7fj2+oqZOFE1UOgtJ/YIqdmChTMfpZo6g6sjxYI3lFDQ2mD
	 s6B2ZLBa22OPATCOzgTGCudHb9nxcUEC9YKPbSqTk9VBglcPM5oJ8U7HEO7RIN972L0QkKFAIX81
	 f5vkzUyZMgvGG8YZ/ctNJDdaTFmcl5ox33e9U43Ge6YJkm/94SxHsr/o3szucRhPcVFnebb8RIWF
	 WOv0idrgxUmDH/uGGuG4OC52GIdHLs+piiBcjg5hM1x+YkPLc9+E0heVQOkZ8Mnvvo6D1c7Ebcq4
	 RP6GqSAEyH+YT4R3c6Sdyygk3hU9PQk+A3LLoEXwL55vvp816HXA4zuskUKBF/kZiX8v8JrLHDvl
	 UF5m+dZgwfngNQILCNHK13O361PqK+zetIMRnr+1AwLZN2q7priRjB56bQTFDaN8QrcB9rZyCrY/
	 N37NqE8xAFn8HG2ftn4zeLs44XZTKRNWctsL9c5LnvTYiJ2fsFKQ92n7KBvNTqTgkaBstPeuJvCa
	 k8q217n5iEEW/t8mcHlB/34wqbAZqoMyvjjF1K1nkUIzZ10MjDaeH33NMfqDzOdk2YD52dg2t8HC
	 4dDlg4PSPKbE+XtSal7K/OEgdFpvrRUJF5weRYQ0EQUvjS+3SJNnI7Y+Bi+ubH9ScNCjAiQMu/Z7
	 AJaELEii2pBdSFFfIaWF8gcxAtNNB10lfX6txIbk7kbsQviFFhfpBrkrdafAhqOIAuvSLUMtRB5o
	 85nY4k5qryFOI4eQHWtNuu1nAt0YBDc9yioyd1fGFGLsjLqG5aw91NOpum1Ilu3KaAi7y91ccyxv
	 /M2GrRzjtRQ3maDNTEEAdYk6MgtQ==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: zhoumin <teczm@foxmail.com>
To: hirofumi@mail.parknet.co.jp
Cc: linux-kernel@vger.kernel.org,
	teczm@foxmail.com
Subject: Re: [PATCH] vfat: fix uninitialized i_pos error
Date: Wed, 20 Aug 2025 01:28:23 +0800
X-OQ-MSGID: <20250819172823.1796981-1-teczm@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <87jz2zz1t9.fsf@mail.parknet.co.jp>
References: <87jz2zz1t9.fsf@mail.parknet.co.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi OGAWA-san,

Thank you for the explanation.

I apologize for the noise and my lack of understanding. I will look into
the code you pointed out  and explore if there's a better approach to
address the original issue.

Best regards,
zhoumin


