Return-Path: <linux-kernel+bounces-859969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1273BEF0F5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 04:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41CAF3AC000
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 02:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2917722A80D;
	Mon, 20 Oct 2025 02:10:18 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC7021B9C5
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760926217; cv=none; b=THUi4xBSKNgt1k8Gn/cbt87qTt6fasknXDOGeB5WNQtpORC8xn/c35GLwGFnyIWGPvmtQ3Og8nwQV8yJO/+Fm0iLkJWE2SOc7w52a2YdYNPcolEE447Hgk6/pqbAZsY0wXMYDR5b9NOHLxulWvOpEEyvGq05T9PvPfLHLf5/3XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760926217; c=relaxed/simple;
	bh=4voyTqMuvyd2+W5XuaEkacCRnBr//Qv/4toj6/dNr/4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DTf/UdG/IwN+UhPBpdycxeRxFqGwiG+/pn/DsBDfK3z+m2AHJy6s7rNHZ3PYiDsXRz9aAZNikt0z8f8ej2LyAmolqG/HMI9+L+pqgzT02GjN1gSe0RTyFq0u3s+ELxVToTYb6Keku9yHhYkf7/0+pGmjAOT0sUYznM1b8IuJz7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowADXK578mfVoxc2IEQ--.23486S2;
	Mon, 20 Oct 2025 10:10:04 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: jpoimboe@kernel.org,
	peterz@infradead.org
Cc: linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] objtool: Remove unneeded semicolon
Date: Mon, 20 Oct 2025 10:09:16 +0800
Message-Id: <20251020020916.1070369-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADXK578mfVoxc2IEQ--.23486S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYD7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87
	Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAK
	zVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx
	8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIF
	xwCY02Avz4vE14v_Gr1l42xK82IYc2Ij64vIr41l4c8EcI0Ec7CjxVAaw2AFwI0_JF0_Jw
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUdnYwUUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
semantic patch at scripts/coccinelle/misc/semicolon.cocci.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 tools/objtool/elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 5feeefc7fc8f..3f20b257ab25 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -451,7 +451,7 @@ static const char *demangle_name(struct symbol *sym)
 			str[i + 1] = '\0';
 			break;
 		}
-	};
+	}
 
 	return str;
 }
-- 
2.25.1


