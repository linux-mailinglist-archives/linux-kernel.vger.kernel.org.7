Return-Path: <linux-kernel+bounces-599024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B640A84DF7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 22:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2A657A571E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 20:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E972A290081;
	Thu, 10 Apr 2025 20:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewfTJCvY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F151F1DF965;
	Thu, 10 Apr 2025 20:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744316013; cv=none; b=Hj/8S35r9lamOYwiJhoucVFKA9HJJaVv20TxckIdqN+nehpgeJt9pmInhKP7SMWv0MhoRaGLVV6C7D9ZAc/r0olfCw5/3HmZGWok9SOPlWWNrz4L8qPmw4XoaBlpjO4452kaX+B1ubNj5LRa/WJ2fzeFtDR4n1mU0P2vLcQFngI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744316013; c=relaxed/simple;
	bh=xEhwAu3xgUU6Amb1UWoZGEieAQxg5xwmELZOlHI/s3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hZ12LtfdKzOqn+wmq35jc8C+dajplGnbZXstN+fRJa/AqPqPJuLkPF/2CavS3C2BZl6M9EfR7ysEZRS39h2bRJkGWoI8Thb8pAqyLcRIdjULKdZ/Lqb1wADNJGNDd1Q6x4P32yMAW0OV86xihMQw7/Z90xbDgU0xpCuqdk8Eqwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewfTJCvY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2701BC4CEDD;
	Thu, 10 Apr 2025 20:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744316012;
	bh=xEhwAu3xgUU6Amb1UWoZGEieAQxg5xwmELZOlHI/s3A=;
	h=From:To:Cc:Subject:Date:From;
	b=ewfTJCvYanYdjM+nFu+OJtK3cQ8yKjegiqAu+GsVEPtTWWU5729dsgTcpL64TQRLm
	 jKE20+Yote16/j4bzaNMWZa2m0FpZibSrweiW31f59MHRXpZto0QoKWLbnMQ0Gh6Jk
	 Q1Fa90HuV9FL7T/VcaMLIMLotv8mxOcTJoH7gKyHL3QZobGXaAgBL5MHH+nzNPPU0+
	 /OImbeR9rj3pEDnpZD34oNa3eRBjfm7WASFGp+MAj2m6dyNJ24+yfecufCiHZLieN1
	 L5FLaXoJDL7l/lCRe1bq9g2sFU5ZTmd3YRfgFIqwmmahnO25qSQy1F5YSGGWDcZt3S
	 0r2QOGuyTpwLg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Samuel Holland <samuel.holland@sifive.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 1/2] dt-bindings: Remove obsolete cpu-topology.txt
Date: Thu, 10 Apr 2025 15:13:22 -0500
Message-ID: <20250410201325.962203-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cpu topology binding is now covered by the dtschema cpu-map.yaml
schema with all the relevant descriptions moved to it.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/cpu/cpu-topology.txt  | 553 ------------------
 1 file changed, 553 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/cpu/cpu-topology.txt

diff --git a/Documentation/devicetree/bindings/cpu/cpu-topology.txt b/Documentation/devicetree/bindings/cpu/cpu-topology.txt
deleted file mode 100644
index 9bd530a35d14..000000000000
--- a/Documentation/devicetree/bindings/cpu/cpu-topology.txt
+++ /dev/null
@@ -1,553 +0,0 @@
-===========================================
-CPU topology binding description
-===========================================
-
-===========================================
-1 - Introduction
-===========================================
-
-In a SMP system, the hierarchy of CPUs is defined through three entities that
-are used to describe the layout of physical CPUs in the system:
-
-- socket
-- cluster
-- core
-- thread
-
-The bottom hierarchy level sits at core or thread level depending on whether
-symmetric multi-threading (SMT) is supported or not.
-
-For instance in a system where CPUs support SMT, "cpu" nodes represent all
-threads existing in the system and map to the hierarchy level "thread" above.
-In systems where SMT is not supported "cpu" nodes represent all cores present
-in the system and map to the hierarchy level "core" above.
-
-CPU topology bindings allow one to associate cpu nodes with hierarchical groups
-corresponding to the system hierarchy; syntactically they are defined as device
-tree nodes.
-
-Currently, only ARM/RISC-V intend to use this cpu topology binding but it may be
-used for any other architecture as well.
-
-The cpu nodes, as per bindings defined in [4], represent the devices that
-correspond to physical CPUs and are to be mapped to the hierarchy levels.
-
-A topology description containing phandles to cpu nodes that are not compliant
-with bindings standardized in [4] is therefore considered invalid.
-
-===========================================
-2 - cpu-map node
-===========================================
-
-The ARM/RISC-V CPU topology is defined within the cpu-map node, which is a direct
-child of the cpus node and provides a container where the actual topology
-nodes are listed.
-
-- cpu-map node
-
-	Usage: Optional - On SMP systems provide CPUs topology to the OS.
-			  Uniprocessor systems do not require a topology
-			  description and therefore should not define a
-			  cpu-map node.
-
-	Description: The cpu-map node is just a container node where its
-		     subnodes describe the CPU topology.
-
-	Node name must be "cpu-map".
-
-	The cpu-map node's parent node must be the cpus node.
-
-	The cpu-map node's child nodes can be:
-
-	- one or more cluster nodes or
-	- one or more socket nodes in a multi-socket system
-
-	Any other configuration is considered invalid.
-
-The cpu-map node can only contain 4 types of child nodes:
-
-- socket node
-- cluster node
-- core node
-- thread node
-
-whose bindings are described in paragraph 3.
-
-The nodes describing the CPU topology (socket/cluster/core/thread) can
-only be defined within the cpu-map node and every core/thread in the
-system must be defined within the topology.  Any other configuration is
-invalid and therefore must be ignored.
-
-===========================================
-2.1 - cpu-map child nodes naming convention
-===========================================
-
-cpu-map child nodes must follow a naming convention where the node name
-must be "socketN", "clusterN", "coreN", "threadN" depending on the node type
-(ie socket/cluster/core/thread) (where N = {0, 1, ...} is the node number; nodes
-which are siblings within a single common parent node must be given a unique and
-sequential N value, starting from 0).
-cpu-map child nodes which do not share a common parent node can have the same
-name (ie same number N as other cpu-map child nodes at different device tree
-levels) since name uniqueness will be guaranteed by the device tree hierarchy.
-
-===========================================
-3 - socket/cluster/core/thread node bindings
-===========================================
-
-Bindings for socket/cluster/cpu/thread nodes are defined as follows:
-
-- socket node
-
-	 Description: must be declared within a cpu-map node, one node
-		      per physical socket in the system. A system can
-		      contain single or multiple physical socket.
-		      The association of sockets and NUMA nodes is beyond
-		      the scope of this bindings, please refer [2] for
-		      NUMA bindings.
-
-	This node is optional for a single socket system.
-
-	The socket node name must be "socketN" as described in 2.1 above.
-	A socket node can not be a leaf node.
-
-	A socket node's child nodes must be one or more cluster nodes.
-
-	Any other configuration is considered invalid.
-
-- cluster node
-
-	 Description: must be declared within a cpu-map node, one node
-		      per cluster. A system can contain several layers of
-		      clustering within a single physical socket and cluster
-		      nodes can be contained in parent cluster nodes.
-
-	The cluster node name must be "clusterN" as described in 2.1 above.
-	A cluster node can not be a leaf node.
-
-	A cluster node's child nodes must be:
-
-	- one or more cluster nodes; or
-	- one or more core nodes
-
-	Any other configuration is considered invalid.
-
-- core node
-
-	Description: must be declared in a cluster node, one node per core in
-		     the cluster. If the system does not support SMT, core
-		     nodes are leaf nodes, otherwise they become containers of
-		     thread nodes.
-
-	The core node name must be "coreN" as described in 2.1 above.
-
-	A core node must be a leaf node if SMT is not supported.
-
-	Properties for core nodes that are leaf nodes:
-
-	- cpu
-		Usage: required
-		Value type: <phandle>
-		Definition: a phandle to the cpu node that corresponds to the
-			    core node.
-
-	If a core node is not a leaf node (CPUs supporting SMT) a core node's
-	child nodes can be:
-
-	- one or more thread nodes
-
-	Any other configuration is considered invalid.
-
-- thread node
-
-	Description: must be declared in a core node, one node per thread
-		     in the core if the system supports SMT. Thread nodes are
-		     always leaf nodes in the device tree.
-
-	The thread node name must be "threadN" as described in 2.1 above.
-
-	A thread node must be a leaf node.
-
-	A thread node must contain the following property:
-
-	- cpu
-		Usage: required
-		Value type: <phandle>
-		Definition: a phandle to the cpu node that corresponds to
-			    the thread node.
-
-===========================================
-4 - Example dts
-===========================================
-
-Example 1 (ARM 64-bit, 16-cpu system, two clusters of clusters in a single
-physical socket):
-
-cpus {
-	#size-cells = <0>;
-	#address-cells = <2>;
-
-	cpu-map {
-		socket0 {
-			cluster0 {
-				cluster0 {
-					core0 {
-						thread0 {
-							cpu = <&CPU0>;
-						};
-						thread1 {
-							cpu = <&CPU1>;
-						};
-					};
-
-					core1 {
-						thread0 {
-							cpu = <&CPU2>;
-						};
-						thread1 {
-							cpu = <&CPU3>;
-						};
-					};
-				};
-
-				cluster1 {
-					core0 {
-						thread0 {
-							cpu = <&CPU4>;
-						};
-						thread1 {
-							cpu = <&CPU5>;
-						};
-					};
-
-					core1 {
-						thread0 {
-							cpu = <&CPU6>;
-						};
-						thread1 {
-							cpu = <&CPU7>;
-						};
-					};
-				};
-			};
-
-			cluster1 {
-				cluster0 {
-					core0 {
-						thread0 {
-							cpu = <&CPU8>;
-						};
-						thread1 {
-							cpu = <&CPU9>;
-						};
-					};
-					core1 {
-						thread0 {
-							cpu = <&CPU10>;
-						};
-						thread1 {
-							cpu = <&CPU11>;
-						};
-					};
-				};
-
-				cluster1 {
-					core0 {
-						thread0 {
-							cpu = <&CPU12>;
-						};
-						thread1 {
-							cpu = <&CPU13>;
-						};
-					};
-					core1 {
-						thread0 {
-							cpu = <&CPU14>;
-						};
-						thread1 {
-							cpu = <&CPU15>;
-						};
-					};
-				};
-			};
-		};
-	};
-
-	CPU0: cpu@0 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x0 0x0>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	CPU1: cpu@1 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x0 0x1>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	CPU2: cpu@100 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x0 0x100>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	CPU3: cpu@101 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x0 0x101>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	CPU4: cpu@10000 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x0 0x10000>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	CPU5: cpu@10001 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x0 0x10001>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	CPU6: cpu@10100 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x0 0x10100>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	CPU7: cpu@10101 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x0 0x10101>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	CPU8: cpu@100000000 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x1 0x0>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	CPU9: cpu@100000001 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x1 0x1>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	CPU10: cpu@100000100 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x1 0x100>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	CPU11: cpu@100000101 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x1 0x101>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	CPU12: cpu@100010000 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x1 0x10000>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	CPU13: cpu@100010001 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x1 0x10001>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	CPU14: cpu@100010100 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x1 0x10100>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	CPU15: cpu@100010101 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x1 0x10101>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-};
-
-Example 2 (ARM 32-bit, dual-cluster, 8-cpu system, no SMT):
-
-cpus {
-	#size-cells = <0>;
-	#address-cells = <1>;
-
-	cpu-map {
-		cluster0 {
-			core0 {
-				cpu = <&CPU0>;
-			};
-			core1 {
-				cpu = <&CPU1>;
-			};
-			core2 {
-				cpu = <&CPU2>;
-			};
-			core3 {
-				cpu = <&CPU3>;
-			};
-		};
-
-		cluster1 {
-			core0 {
-				cpu = <&CPU4>;
-			};
-			core1 {
-				cpu = <&CPU5>;
-			};
-			core2 {
-				cpu = <&CPU6>;
-			};
-			core3 {
-				cpu = <&CPU7>;
-			};
-		};
-	};
-
-	CPU0: cpu@0 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a15";
-		reg = <0x0>;
-	};
-
-	CPU1: cpu@1 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a15";
-		reg = <0x1>;
-	};
-
-	CPU2: cpu@2 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a15";
-		reg = <0x2>;
-	};
-
-	CPU3: cpu@3 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a15";
-		reg = <0x3>;
-	};
-
-	CPU4: cpu@100 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a7";
-		reg = <0x100>;
-	};
-
-	CPU5: cpu@101 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a7";
-		reg = <0x101>;
-	};
-
-	CPU6: cpu@102 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a7";
-		reg = <0x102>;
-	};
-
-	CPU7: cpu@103 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a7";
-		reg = <0x103>;
-	};
-};
-
-Example 3: HiFive Unleashed (RISC-V 64 bit, 4 core system)
-
-{
-	#address-cells = <2>;
-	#size-cells = <2>;
-	compatible = "sifive,fu540g", "sifive,fu500";
-	model = "sifive,hifive-unleashed-a00";
-
-	...
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		cpu-map {
-			socket0 {
-				cluster0 {
-					core0 {
-						cpu = <&CPU1>;
-					};
-					core1 {
-						cpu = <&CPU2>;
-					};
-					core2 {
-						cpu0 = <&CPU2>;
-					};
-					core3 {
-						cpu0 = <&CPU3>;
-					};
-				};
-			};
-		};
-
-		CPU1: cpu@1 {
-			device_type = "cpu";
-			compatible = "sifive,rocket0", "riscv";
-			reg = <0x1>;
-		}
-
-		CPU2: cpu@2 {
-			device_type = "cpu";
-			compatible = "sifive,rocket0", "riscv";
-			reg = <0x2>;
-		}
-		CPU3: cpu@3 {
-			device_type = "cpu";
-			compatible = "sifive,rocket0", "riscv";
-			reg = <0x3>;
-		}
-		CPU4: cpu@4 {
-			device_type = "cpu";
-			compatible = "sifive,rocket0", "riscv";
-			reg = <0x4>;
-		}
-	}
-};
-===============================================================================
-[1] ARM Linux kernel documentation
-    Documentation/devicetree/bindings/arm/cpus.yaml
-[2] Devicetree NUMA binding description
-    Documentation/devicetree/bindings/numa.txt
-[3] RISC-V Linux kernel documentation
-    Documentation/devicetree/bindings/riscv/cpus.yaml
-[4] https://www.devicetree.org/specifications/
-- 
2.47.2


